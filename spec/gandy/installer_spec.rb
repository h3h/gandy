require 'spec_helper'

describe Gandy::Installer do
  subject { described_class.new(git_dir, hook_file, bundled_hook_file) }

  let(:hook_file) { double(file?: true, to_s: '.git/hooks/post-checkout', readlines: [], writable?: false) }
  let(:bundled_hook_file) { double(file?: true, to_s: 'gem/bin/gandy-post-checkout') }

  before { allow(Gandy).to receive(:print) }

  describe "#install!" do
    context "with a valid .git directory" do
      let(:git_dir) { double(directory?: true, to_s: '.git') }

      it "doesn't call exit" do
        expect { subject.install! }.not_to raise_exception
      end
    end

    context "without a valid .git directory" do
      let(:git_dir) { double(directory?: false) }

      it "calls exit(1)" do
        expect { subject.install! }.to raise_exception(SystemExit)
      end
    end
  end
end
