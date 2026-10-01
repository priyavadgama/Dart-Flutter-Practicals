// Practical 27: Mixin with 'on' Constraint
// Write a mixin with an 'on' constraint applied to a base class Account,
// where the mixin adds InterestCalculator capability calculating 5% interest on balance.

abstract class Account {
  final String accountHolder;
  final String accountNumber;
  double balance;

  Account({
    required this.accountHolder,
    required this.accountNumber,
    required this.balance,
  });

  void displayAccountInfo() {
    print('Account Holder : $accountHolder');
    print('Account Number : $accountNumber');
    print('Current Balance: ₹${balance.toStringAsFixed(2)}');
  }
}

// Mixin restricted to classes that extend Account using 'on' keyword
mixin InterestCalculator on Account {
  double calculateAnnualInterest({double ratePercentage = 5.0}) {
    double interest = (balance * ratePercentage) / 100.0;
    return interest;
  }

  void creditAnnualInterest({double ratePercentage = 5.0}) {
    double interest = calculateAnnualInterest(ratePercentage: ratePercentage);
    balance += interest;
    print('📈 [InterestCalculator]: 5% Annual interest of ₹${interest.toStringAsFixed(2)} credited successfully.');
    print('💰 New Account Balance : ₹${balance.toStringAsFixed(2)}');
  }
}

// Concrete class extending Account and applying InterestCalculator mixin
class SavingsAccount extends Account with InterestCalculator {
  SavingsAccount({
    required super.accountHolder,
    required super.accountNumber,
    required super.balance,
  });
}

void main() {
  print('========================================');
  print('Practical 27: Mixin with "on" Constraint');
  print('========================================');

  // Hypothetical student savings account
  final myAccount = SavingsAccount(
    accountHolder: 'Vadgama Priya Ashokbhai (Roll: 35)',
    accountNumber: 'SB-ATMIYA-2026-0035',
    balance: 75000.0,
  );

  print('Initial State:');
  myAccount.displayAccountInfo();
  print('----------------------------------------');

  // Calculate and credit 5% annual interest
  print('Applying 5% Annual Interest via Mixin:');
  double computedInterest = myAccount.calculateAnnualInterest(ratePercentage: 5.0);
  print('Computed Interest (5%): ₹${computedInterest.toStringAsFixed(2)}');
  print('----------------------------------------');

  myAccount.creditAnnualInterest(ratePercentage: 5.0);
  print('----------------------------------------');
  print('Updated State:');
  myAccount.displayAccountInfo();
}
