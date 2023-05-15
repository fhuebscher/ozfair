# OzFair
## The neobank app with the possibility to split expenses directly.

- Florian Hübscher, 14039008
- Magnus Andersen, 14188674
- Joel Weber, 24651248
- Fabian Roth, 14226967

https://github.com/fhuebscher/ozfair

Installation steps: 
1. Clone the repository in XCode.
2. If you have not installed CocoaPods, install it via ``` $ brew install cocoapods ```
3. If you have an M1/M2 chip, enter ``` $ sudo arch -x86_64 gem install ffi arch -x86_64 ```
4. Last, navigate into the project root and enter ``` $ pod install ```
5. You should see a message in the terminal stating that one pod has been installed.

There exist two more branches named "Design" and "Presentation", which include the figma files for the design cycles and the pptx for the presentation.


## Functionality Details

### Currency Echange Rate Functionality

Use of publicly accessible ECB dataset:

  https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml

### Data store 

  We are utilising a Datastore as an ObservableObject to keep track of the transactions.

  Some functionalities have been reduced to a minimum using mock data such as in the TranfsferService. 