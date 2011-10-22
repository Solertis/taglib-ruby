require 'helper'

class TestMPEGFile < Test::Unit::TestCase
  context "The crash.mp3 file" do
    setup do
      read_properties = true
      @file = TagLib::MPEG::File.new("test/data/crash.mp3", read_properties)
    end

    context "audio properties" do
      setup do
        @properties = @file.audio_properties
      end

      should "be MPEG audio properties" do
        assert_equal TagLib::MPEG::Properties, @properties.class
      end

      should "contain information" do
        assert_equal 2, @properties.length
        assert_equal 157, @properties.bitrate
        assert_equal 44100, @properties.sample_rate
        assert_equal 2, @properties.channels
        assert_equal TagLib::MPEG::Header::Version1, @properties.version
        assert_equal 3, @properties.layer
        assert_equal false, @properties.protection_enabled
        assert_equal TagLib::MPEG::Header::JointStereo, @properties.channel_mode
        assert_equal false, @properties.copyrighted?
        assert_equal true, @properties.original?
      end

      context "Xing header" do
        setup do
          @xing_header = @properties.xing_header
        end

        should "exist" do
          assert_not_nil @xing_header
        end

        should "contain information" do
          assert_true @xing_header.valid?
          assert_equal 88, @xing_header.total_frames
          assert_equal 45140, @xing_header.total_size
        end
      end
    end
  end
end