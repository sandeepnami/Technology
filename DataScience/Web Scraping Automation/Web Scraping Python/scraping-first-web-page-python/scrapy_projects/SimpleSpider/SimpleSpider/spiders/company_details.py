import scrapy


class CompanyDetailsSpider(scrapy.Spider):
	name = 'company_details'
	allowed_domains = ['finance.yahoo.com']
	start_urls = ['https://finance.yahoo.com/sector/ms_technology']

	def parse(self, response):
		company_names_list = response.xpath(
			'//*[@id="scr-res-table"]/div[1]/table/tbody/tr/td[2]/text()').extract()
		company_price_list = response.xpath(
			'//*[@id="scr-res-table"]/div[1]/table/tbody/tr/td[3]/span/text()').extract()

		count = len(company_names_list)

		for i in range(0, count):

			print(company_names_list[i], company_price_list[i])