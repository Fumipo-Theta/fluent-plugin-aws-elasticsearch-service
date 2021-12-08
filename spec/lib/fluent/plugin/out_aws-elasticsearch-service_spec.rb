# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Fluent::Plugin::AwsElasticsearchServiceOutput do
  let(:driver)   { Fluent::Test::Driver::Output.new(Fluent::Plugin::AwsElasticsearchServiceOutput).configure(config) }
  let(:instance) { driver.instance }

  describe "config" do
    let(:config) do
      %[
      <endpoint>
        region us-east-1
        url  http://localhost:9200
      </endpoint>
      ]
    end

    it "`endpoint` is array." do
      instance.endpoint.map do |ep|
        expect(ep[:url]).to eq "http://localhost:9200"
      end
    end

    it "should get region" do
      instance.endpoint.map do |ep|
        expect(ep[:region]).to eq "us-east-1"
      end
    end

    it "should get default values" do
      instance.endpoint.map do |ep|
        expect(ep[:access_key_id]).to eq ""
        expect(ep[:secret_access_key]).to eq ""
        expect(ep[:assume_role_arn]).to eq nil
        expect(ep[:assume_role_session_name]).to eq "fluentd"
      end
    end
  end
end
