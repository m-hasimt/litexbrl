module LiteXBRL
  module TDnet
    class Summary2 < FinancialInformation2

      attr_accessor :net_sales, :operating_income, :ordinary_income, :net_income, :net_income_per_share,
        :forecast_net_sales, :forecast_operating_income, :forecast_ordinary_income, :forecast_net_income, :forecast_net_income_per_share

      def self.find_data(doc, xbrl, accounting_base, context)
        # 売上高
        xbrl.net_sales = to_mill(find_value_tse_ed_t(doc, NET_SALES[accounting_base], context[:context_duration]))
        # 営業利益
        xbrl.operating_income = to_mill(find_value_tse_ed_t(doc, OPERATING_INCOME[accounting_base], context[:context_duration]))
        # 経常利益
        xbrl.ordinary_income = to_mill(find_value_tse_ed_t(doc, ORDINARY_INCOME[accounting_base], context[:context_duration]))
        # 純利益
        xbrl.net_income = to_mill(find_value_tse_ed_t(doc, NET_INCOME[accounting_base], context[:context_duration]))
        # 1株当たり純利益
        xbrl.net_income_per_share = to_f(find_value_tse_ed_t(doc, NET_INCOME_PER_SHARE[accounting_base], context[:context_duration]))

        # 通期予想売上高
        xbrl.forecast_net_sales = to_mill(find_value_tse_ed_t(doc, NET_SALES[accounting_base], context[:context_forecast].call(xbrl.quarter)))
        # 通期予想営業利益
        xbrl.forecast_operating_income = to_mill(find_value_tse_ed_t(doc, OPERATING_INCOME[accounting_base], context[:context_forecast].call(xbrl.quarter)))
        # 通期予想経常利益
        xbrl.forecast_ordinary_income = to_mill(find_value_tse_ed_t(doc, ORDINARY_INCOME[accounting_base], context[:context_forecast].call(xbrl.quarter)))
        # 通期予想純利益
        xbrl.forecast_net_income = to_mill(find_value_tse_ed_t(doc, NET_INCOME[accounting_base], context[:context_forecast].call(xbrl.quarter)))
        # 通期予想1株当たり純利益
        xbrl.forecast_net_income_per_share = to_f(find_value_tse_ed_t(doc, NET_INCOME_PER_SHARE[accounting_base], context[:context_forecast].call(xbrl.quarter)))

        xbrl
      end

      def self.find_consolidation(doc, season)
        cons = doc.at_xpath("//ix:nonFraction[@contextRef='Current#{season}Duration_ConsolidatedMember_ResultMember' and @name='tse-ed-t:NetSales']")
        non_cons = doc.at_xpath("//ix:nonFraction[@contextRef='Current#{season}Duration_NonConsolidatedMember_ResultMember' and @name='tse-ed-t:NetSales']")

        if cons
          "Consolidated"
        elsif non_cons
          "NonConsolidated"
        else
          raise Exception.new("連結・非連結ともに該当しません。")
        end
      end

      def self.find_accounting_base(doc, context)
        namespace = doc.namespaces.keys.find {|ns| ns.start_with?('xmlns:tse-qced') || ns.start_with?('xmlns:tse-aced') }

        case namespace
        when /.+jpsm.+/
          :jp
        when /.+ussm.+/
          :us
        when /.+ifsm.+/
          :if
        else
          raise Exception.new("会計基準を取得出来ません。")
        end
      end

      def attributes
        {
          code: code,
          year: year,
          month: month,
          quarter: quarter,
          net_sales: net_sales,
          operating_income: operating_income,
          ordinary_income: ordinary_income,
          net_income: net_income,
          net_income_per_share: net_income_per_share
        }
      end

      def attributes_results_forecast
        {
          code: code,
          year: quarter == 4 ? year + 1 : year,
          month: month,
          quarter: quarter,
          forecast_net_sales: forecast_net_sales,
          forecast_operating_income: forecast_operating_income,
          forecast_ordinary_income: forecast_ordinary_income,
          forecast_net_income: forecast_net_income,
          forecast_net_income_per_share: forecast_net_income_per_share
        }
      end

    end
  end
end