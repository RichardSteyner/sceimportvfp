public class ContactEverBridgeObject {
	public static void consumeObject(JSONParser parser) {
		Integer depth = 0;
		do {
			JSONToken curr = parser.getCurrentToken();
			if (curr == JSONToken.START_OBJECT || 
				curr == JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == JSONToken.END_OBJECT ||
				curr == JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}

	public class GisLocation {
		public Double lon {get;set;} 
		public Double lat {get;set;} 

		public GisLocation(JSONParser parser) {
			while (parser.nextToken() != JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != JSONToken.VALUE_NULL) {
						if (text == 'lon') {
							lon = parser.getDoubleValue();
						} else if (text == 'lat') {
							lat = parser.getDoubleValue();
						} else {
							System.debug(LoggingLevel.WARN, 'GisLocation consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class ContactAttributes {
		public List<String> values {get;set;} 
		public Long orgAttrId {get;set;} 
		public String name {get;set;} 

		public ContactAttributes(JSONParser parser) {
			while (parser.nextToken() != JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != JSONToken.VALUE_NULL) {
						if (text == 'values') {
							values = new List<String>();
							while (parser.nextToken() != JSONToken.END_ARRAY) {
								values.add(String.valueOf(parser));
							}
						} else if (text == 'orgAttrId') {
							orgAttrId = parser.getLongValue();
						} else if (text == 'name') {
							name = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'ContactAttributes consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class ContactEverBridgeObj {
		public String message {get;set;} 
		public String firstPageUri {get;set;} 
		public String lastPageUri {get;set;} 
		public PageZ page {get;set;} 

		public ContactEverBridgeObj(JSONParser parser) {
			while (parser.nextToken() != JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != JSONToken.VALUE_NULL) {
						if (text == 'message') {
							message = parser.getText();
						} else if (text == 'firstPageUri') {
							firstPageUri = parser.getText();
						} else if (text == 'lastPageUri') {
							lastPageUri = parser.getText();
						} else if (text == 'page') {
							page = new PageZ(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'JSON2Apex consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Address {
		public String streetAddress {get;set;} 
		public String postalCode {get;set;} 
		public String state {get;set;} 
		public String locationName {get;set;} 
		public GisLocation gisLocation {get;set;} 
		public String country {get;set;} 
		public String city {get;set;} 
		public Integer locationId {get;set;} 
		public Integer locationSourceId {get;set;} 

		public Address(JSONParser parser) {
			while (parser.nextToken() != JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != JSONToken.VALUE_NULL) {
						if (text == 'streetAddress') {
							streetAddress = parser.getText();
						} else if (text == 'postalCode') {
							postalCode = parser.getText();
						} else if (text == 'state') {
							state = parser.getText();
						} else if (text == 'locationName') {
							locationName = parser.getText();
						} else if (text == 'gisLocation') {
							gisLocation = new GisLocation(parser);
						} else if (text == 'country') {
							country = parser.getText();
						} else if (text == 'city') {
							city = parser.getText();
						} else if (text == 'locationId') {
							locationId = parser.getIntegerValue();
						} else if (text == 'locationSourceId') {
							locationSourceId = parser.getIntegerValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Address consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Data {
		public Long lastModifiedTime {get;set;} 
		public Long organizationId {get;set;} 
		public Long createdDate {get;set;} 
		public String createdName {get;set;} 
		public String lastName {get;set;} 
		public String status {get;set;} 
		public String country {get;set;} 
		public Long recordTypeId {get;set;} 
		public List<ContactAttributes> contactAttributes {get;set;} 
		public String lastModifiedName {get;set;} 
		public Integer accountId {get;set;} 
		public String externalId {get;set;} 
		public Long id {get;set;} 
		public List<Paths> paths {get;set;} 
		public String firstName {get;set;} 
		public Boolean uploadProcessing {get;set;} 
		public Integer resourceBundleId {get;set;} 
		public List<Address> address {get;set;} 
		public String middleInitial {get;set;} 
		public Long createdId {get;set;} 
		public Long lastModifiedId {get;set;} 
		public Long lastModifiedDate {get;set;} 
		public String registedEmail {get;set;} 
		public String registeredEmail {get;set;} 
		public Long registedDate {get;set;} 
		public Long registeredDate {get;set;} 
		public Long individualAccountId {get;set;} 
		public String timezoneId {get;set;} 

		public Data(JSONParser parser) {
			while (parser.nextToken() != JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != JSONToken.VALUE_NULL) {
						if (text == 'lastModifiedTime') {
							lastModifiedTime = parser.getLongValue();
						} else if (text == 'organizationId') {
							organizationId = parser.getLongValue();
						} else if (text == 'createdDate') {
							createdDate = parser.getLongValue();
						} else if (text == 'createdName') {
							createdName = parser.getText();
						} else if (text == 'lastName') {
							lastName = parser.getText();
						} else if (text == 'status') {
							status = parser.getText();
						} else if (text == 'country') {
							country = parser.getText();
						} else if (text == 'recordTypeId') {
							recordTypeId = parser.getLongValue();
						} else if (text == 'contactAttributes') {
							contactAttributes = new List<ContactAttributes>();
							while (parser.nextToken() != JSONToken.END_ARRAY) {
								contactAttributes.add(new ContactAttributes(parser));
							}
						} else if (text == 'lastModifiedName') {
							lastModifiedName = parser.getText();
						} else if (text == 'accountId') {
							accountId = parser.getIntegerValue();
						} else if (text == 'externalId') {
							externalId = parser.getText();
						} else if (text == 'id') {
							id = parser.getLongValue();
						} else if (text == 'paths') {
							paths = new List<Paths>();
							while (parser.nextToken() != JSONToken.END_ARRAY) {
								paths.add(new Paths(parser));
							}
						} else if (text == 'firstName') {
							firstName = parser.getText();
						} else if (text == 'uploadProcessing') {
							uploadProcessing = parser.getBooleanValue();
						} else if (text == 'resourceBundleId') {
							resourceBundleId = parser.getIntegerValue();
						} else if (text == 'address') {
							address = new List<Address>();
							while (parser.nextToken() != JSONToken.END_ARRAY) {
								address.add(new Address(parser));
							}
						} else if (text == 'middleInitial') {
							middleInitial = parser.getText();
						} else if (text == 'createdId') {
							createdId = parser.getLongValue();
						} else if (text == 'lastModifiedId') {
							lastModifiedId = parser.getLongValue();
						} else if (text == 'lastModifiedDate') {
							lastModifiedDate = parser.getLongValue();
						} else if (text == 'registedEmail') {
							registedEmail = parser.getText();
						} else if (text == 'registeredEmail') {
							registeredEmail = parser.getText();
						} else if (text == 'registedDate') {
							registedDate = parser.getLongValue();
						} else if (text == 'registeredDate') {
							registeredDate = parser.getLongValue();
						} else if (text == 'individualAccountId') {
							individualAccountId = parser.getLongValue();
						} else if (text == 'timezoneId') {
							timezoneId = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Data consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class PageZ {
		public Integer pageSize {get;set;} 
		public Integer start {get;set;} 
		public List<Data> data {get;set;} 
		public Integer totalCount {get;set;} 
		public Integer totalPageCount {get;set;} 
		public Integer currentPageNo {get;set;} 

		public PageZ(JSONParser parser) {
			while (parser.nextToken() != JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != JSONToken.VALUE_NULL) {
						if (text == 'pageSize') {
							pageSize = parser.getIntegerValue();
						} else if (text == 'start') {
							start = parser.getIntegerValue();
						} else if (text == 'data') {
							data = new List<Data>();
							while (parser.nextToken() != JSONToken.END_ARRAY) {
								data.add(new Data(parser));
							}
						} else if (text == 'totalCount') {
							totalCount = parser.getIntegerValue();
						} else if (text == 'totalPageCount') {
							totalPageCount = parser.getIntegerValue();
						} else if (text == 'currentPageNo') {
							currentPageNo = parser.getIntegerValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Page consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Paths {
		public Integer waitTime {get;set;} 
		public String status {get;set;} 
		public Long pathId {get;set;} 
		public String countryCode {get;set;} 
		public String value {get;set;} 
		public Boolean skipValidation {get;set;} 

		public Paths(JSONParser parser) {
			while (parser.nextToken() != JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != JSONToken.VALUE_NULL) {
						if (text == 'waitTime') {
							waitTime = parser.getIntegerValue();
						} else if (text == 'status') {
							status = parser.getText();
						} else if (text == 'pathId') {
							pathId = parser.getLongValue();
						} else if (text == 'countryCode') {
							countryCode = parser.getText();
						} else if (text == 'value') {
							value = parser.getText();
						} else if (text == 'skipValidation') {
							skipValidation = parser.getBooleanValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Paths consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static ContactEverBridgeObj parse(String json) {
		return new ContactEverBridgeObj(System.JSON.createParser(json));
	}
}