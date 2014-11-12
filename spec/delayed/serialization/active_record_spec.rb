require "helper"

describe ActiveRecord do
  it "loads classes with non-default primary key" do
    expect do
      load_yaml(Story.create.to_yaml)
    end.not_to raise_error
  end

  it "loads classes even if not in default scope" do
    expect do
      load_yaml(Story.create(scoped: false).to_yaml)
    end.not_to raise_error
  end

  it "loads embedded classes even if not in default scope" do
    job = StoryJob.new(Story.create(scoped: false))
    expect do
      load_yaml(job.to_yaml)
    end.not_to raise_error
  end

  def load_yaml(yaml)
    if YAML.respond_to?(:load_dj)
      YAML.load_dj(yaml)
    else
      YAML.load(yaml)
    end
  end

  StoryJob = Struct.new(:story) do
    def perform

    end
  end
end
