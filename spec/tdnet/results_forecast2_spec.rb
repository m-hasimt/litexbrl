require 'spec_helper'
require 'support/nokogiri_helper'

module LiteXBRL
  module TDnet
    describe ResultsForecast do
      include NokogiriHelper

      let(:dir) { File.expand_path '../../data/tdnet/results_forecast2', __FILE__ }

      describe ".parse" do
        context '日本会計基準' do
          context "連結" do
            let(:xbrl) { ResultsForecast2.parse("#{dir}/jp-cons-2014.htm") }

            it do
              expect(xbrl.code).to eq('6883')
              expect(xbrl.year).to eq(2014)
              expect(xbrl.month).to eq(3)
              expect(xbrl.quarter).to eq(4)

              expect(xbrl.forecast_previous_net_sales).to eq(29000)
              expect(xbrl.forecast_previous_operating_income).to eq(4150)
              expect(xbrl.forecast_previous_ordinary_income).to eq(4350)
              expect(xbrl.forecast_previous_net_income).to eq(3000)
              expect(xbrl.forecast_previous_net_income_per_share).to eq(45.25)

              expect(xbrl.forecast_net_sales).to eq(30500)
              expect(xbrl.forecast_operating_income).to eq(5000)
              expect(xbrl.forecast_ordinary_income).to eq(5200)
              expect(xbrl.forecast_net_income).to eq(3800)
              expect(xbrl.forecast_net_income_per_share).to eq(57.31)

              expect(xbrl.change_forecast_net_sales).to eq(0.052)
              expect(xbrl.change_forecast_operating_income).to eq(0.205)
              expect(xbrl.change_forecast_ordinary_income).to eq(0.195)
              expect(xbrl.change_forecast_net_income).to eq(0.267)
            end
          end
        end

=begin
        context '米国会計基準' do
          context '連結' do
            let(:xbrl) { ResultsForecast.parse("#{dir}/us-cons-2014.xbrl") }

            it do
              expect(xbrl.code).to eq('6594')
              expect(xbrl.year).to eq(2014)
              expect(xbrl.month).to eq(3)
              expect(xbrl.quarter).to eq(4)

              expect(xbrl.forecast_net_sales).to eq(850000)
              expect(xbrl.forecast_operating_income).to eq(80000)
              expect(xbrl.forecast_ordinary_income).to eq(78000)
              expect(xbrl.forecast_net_income).to eq(55000)
              expect(xbrl.forecast_net_income_per_share).to eq(404.26)
              expect(xbrl.forecast_previous_net_sales).to eq(820000)
              expect(xbrl.forecast_previous_operating_income).to eq(75000)
              expect(xbrl.forecast_previous_ordinary_income).to eq(73000)
              expect(xbrl.forecast_previous_net_income).to eq(53500)
              expect(xbrl.forecast_previous_net_income_per_share).to eq(398.72)
            end
          end
        end

        context 'IFRS' do
          context '連結' do
            let(:xbrl) { ResultsForecast.parse("#{dir}/ifrs-cons-2014.xbrl") }

            it do
              expect(xbrl.code).to eq('6779')
              expect(xbrl.year).to eq(2014)
              expect(xbrl.month).to eq(3)
              expect(xbrl.quarter).to eq(4)

              expect(xbrl.forecast_net_sales).to eq(51000)
              expect(xbrl.forecast_operating_income).to eq(700)
              expect(xbrl.forecast_ordinary_income).to eq(500)
              expect(xbrl.forecast_net_income).to eq(400)
              expect(xbrl.forecast_net_income_per_share).to eq(20.38)
              expect(xbrl.forecast_previous_net_sales).to eq(51000)
              expect(xbrl.forecast_previous_operating_income).to eq(1500)
              expect(xbrl.forecast_previous_ordinary_income).to eq(1100)
              expect(xbrl.forecast_previous_net_income).to eq(1000)
              expect(xbrl.forecast_previous_net_income_per_share).to eq(50.95)
            end
          end
        end
=end
      end

      describe "#attributes" do
        it do
          results_forecast = ResultsForecast2.new
          results_forecast.code = 1111
          results_forecast.year = 2013
          results_forecast.month = 3
          results_forecast.quarter = 1
          results_forecast.forecast_net_sales = 100
          results_forecast.forecast_operating_income = 10
          results_forecast.forecast_ordinary_income = 11
          results_forecast.forecast_net_income = 6
          results_forecast.forecast_net_income_per_share = 123.1

          results_forecast.forecast_previous_net_sales = 90
          results_forecast.forecast_previous_operating_income = 9
          results_forecast.forecast_previous_ordinary_income = 10
          results_forecast.forecast_previous_net_income = 5
          results_forecast.forecast_previous_net_income_per_share = 113.1

          results_forecast.change_forecast_net_sales = 110
          results_forecast.change_forecast_operating_income = 20
          results_forecast.change_forecast_ordinary_income = 21
          results_forecast.change_forecast_net_income = 16

          attr = results_forecast.attributes

          expect(attr[:code]).to eq(1111)
          expect(attr[:year]).to eq(2013)
          expect(attr[:month]).to eq(3)
          expect(attr[:quarter]).to eq(1)
          expect(attr[:forecast_net_sales]).to eq(100)
          expect(attr[:forecast_operating_income]).to eq(10)
          expect(attr[:forecast_ordinary_income]).to eq(11)
          expect(attr[:forecast_net_income]).to eq(6)
          expect(attr[:forecast_net_income_per_share]).to eq(123.1)

          expect(attr[:forecast_previous_net_sales]).to eq(90)
          expect(attr[:forecast_previous_operating_income]).to eq(9)
          expect(attr[:forecast_previous_ordinary_income]).to eq(10)
          expect(attr[:forecast_previous_net_income]).to eq(5)
          expect(attr[:forecast_previous_net_income_per_share]).to eq(113.1)

          expect(attr[:change_forecast_net_sales]).to eq(110)
          expect(attr[:change_forecast_operating_income]).to eq(20)
          expect(attr[:change_forecast_ordinary_income]).to eq(21)
          expect(attr[:change_forecast_net_income]).to eq(16)
        end
      end

    end
  end
end