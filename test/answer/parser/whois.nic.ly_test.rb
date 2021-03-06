require 'test_helper'
require 'whois/answer/parser/whois.nic.ly.rb'

class AnswerParserWhoisNicLyTest < Whois::Answer::Parser::TestCase

  def setup
    @klass  = Whois::Answer::Parser::WhoisNicLy
    @host   = "whois.nic.ly"
  end


  def test_status
    assert_equal  :available,
                  @klass.new(load_part('/available.txt')).status
    assert_equal  :registered,
                  @klass.new(load_part('/registered.txt')).status
  end

  def test_available?
    assert !@klass.new(load_part('/registered.txt')).available?
    assert  @klass.new(load_part('/available.txt')).available?
  end

  def test_registered?
    assert !@klass.new(load_part('/available.txt')).registered?
    assert  @klass.new(load_part('/registered.txt')).registered?
  end


  def test_created_on
    assert_equal  Time.parse("2007-10-03 13:36:48"),
                  @klass.new(load_part('/registered.txt')).created_on
    assert_equal  nil,
                  @klass.new(load_part('/available.txt')).created_on
  end

  def test_updated_on
    assert_equal  Time.parse("2009-08-07 22:52:02"),
                  @klass.new(load_part('/registered.txt')).updated_on
    assert_equal  nil,
                  @klass.new(load_part('/available.txt')).updated_on
  end

  def test_expires_on
    assert_equal  Time.parse("2010-10-03 13:36:48"),
                  @klass.new(load_part('/registered.txt')).expires_on
    assert_equal  nil,
                  @klass.new(load_part('/available.txt')).expires_on
  end

end