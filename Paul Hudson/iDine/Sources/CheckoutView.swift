// Series on Swift UI by Paul Hudson.
// Website: https://www.hackingwithswift.com
// Youtube: https://www.youtube.com/channel/UCmJi5RdDLgzvkl3Ly0DRMlQ
// Twitter: https://twitter.com/twostraws
import SwiftUI

struct CheckoutView: View {
    static let paymentTypes = ["Cash", "Credit Card", "iDine Points"]
    static let tipAmounts = [10, 15, 20, 25, 0]
    
    @EnvironmentObject var order: Order
    @State private var paymentType = 0
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State private var tipAmount = 1
    @State private var showingPaymentAlert = false
    
    var totalPrice: Double {
        let total = Double(order.total)
        let tipValue = total / 100 * Double(Self.tipAmounts[self.tipAmount])
        return total + tipValue
    }
    
    var body: some View {
        Form {
            Section {
                Picker("How do you want to pay?", selection: self.$paymentType) {
                    ForEach(0..<Self.paymentTypes.count) {
                        Text(Self.paymentTypes[$0])
                    }
                }
                
                Toggle(isOn: self.$addLoyaltyDetails.animation()) { Text("Add iDine loyalty card") }
                
                if self.addLoyaltyDetails {
                    TextField("Enter your iDine ID", text: self.$loyaltyNumber)
                }
            }
            
            Section(header: Text("Add a tip?")) {
                Picker("Percentage:", selection: self.$tipAmount) {
                    ForEach(0..<Self.tipAmounts.count) {
                        Text("\(Self.tipAmounts[$0])%")
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("TOTAL: $\(self.totalPrice, specifier: "%.2f")").font(.largeTitle)) {
                Button("Confirm order") {
                    self.showingPaymentAlert.toggle()
                }
            }
        }.navigationBarTitle(Text("Payment"), displayMode: .inline)
        .alert(isPresented: self.$showingPaymentAlert) {
            Alert(title: Text("Order confirmed"), message: Text("Your total was $\(totalPrice, specifier: "%2.f") - thank you!"), dismissButton: .default(Text("OK")))
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static let order = Order()
    
    static var previews: some View {
        CheckoutView()
            .environmentObject(self.order)
    }
}
