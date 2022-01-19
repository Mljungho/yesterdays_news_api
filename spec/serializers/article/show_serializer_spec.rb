RSpec.describe Article::ShowSerializer, type: :serializer do
  let(:article) { create(:article) }
  let(:serialization) do
    ActiveModelSerializers::SerializableResource.new(
      artiicle,
      serializer: described_class
    )
  end

  subject { JSON.parse(serialization.to_json) }

  it 'is expected to wrap data in a key reflecting the resource name' do
    expect(subject.keys).to match ['article']
  end

  it 'is expected to include relevant keys' do
    expected_keys = %w[id title body category published]
    expect(subject['article'].keys).to eq expected_keys
    # Takes the order into account. If it doesn't match, it will fail the test.
  end

  it 'is expected to contain keys with values of specific data types' do
    expect(subject).to match(
      'article' => {
        'id' => an_instance_of(Integer),
        'title' => an_instance_of(String),
        'body' => an_instance_of(String),
        'category' => an_instance_of(String),
        'published' => an_instance_of(String)
      }
    )
  end
end
