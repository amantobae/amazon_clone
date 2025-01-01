# amazon_clone

**Flutter Amazon Clone Application with Node.js Server**  

This is a full-featured e-commerce application for users as well as the admin. It's divided into two parts:  

1. **User Application**  
2. **Admin Application**  

### **Features of the Application**  

#### **Admin Panel**
The Admin application is a strong tool for administrators to efficiently manage and oversee all aspects of the platform with ease. Following are some of the key features: 1. **Add and Sell Products**: - Adding new products to the catalog is easy, along with their details like name, description, price, and images. - Keep track of the inventory level of each product. 2. **Manage Order Statuses**:
- Real-time update of order status: pending, shipped, delivered, among others.  
   - Let users know the state of their orders.  

3. **Delete Products**:  
   - Outdated products or unavailable ones are deleted from the catalog.  
   - A relevant and cleaned product database is kept.  

4. **View Analytics** *(in development)*:
- Derive useful insights on sale trends, customer behavior, and product trends.  
- Marketing strategies and promotions based on decision-making skills.  

#### **User Application** 
The user application covers all customer needs. Listed below are some of its features utilized by customers in general: 
1. **Browse and Buy Products** :
- Search in plenty of products, their details, reviews, including images.  
   - Add to Cart and checkout with ease.  
   - Supports a variety of payments, from **Apple Pay** and **Google Pay** for speed and security.  

2. **Place Orders**: 
   - Place orders with just a few taps.
- Have order summary and confirmation at one's fingertips immediately. 

3. **Modify the Delivery Location**
 	- Define and edit, at any stage in placing an order, where something has to be delivered. 
 	- Have updates on the location for your delivery at a specified address.

4. **Follow Order Status in Real-time:
- View the status of the placed order: Example: processing, shipped, delivered.  
   - Receive notifications on estimated delivery times.  

5. **Rate and Review Products**: 
   - Provide feedback about the purchased products through rating and review comments. 
   - Help other customers to make better purchase decisions. 

6. **Deal of the Day**:
- Get daily deals and exclusive discounts on selected products.  
   - Limited-time offers to enhance user engagement.  

7. **Search and Filter Products**:  
   - Locate desired products using an advanced search functionality.  
   - Filter through categories, price range, ratings, etc.  

8. **Personalized Recommendations** *(for future updates)*:
- Obtain product recommendations based on browse history and purchase behavior.  

### **Technical Overview**
- **Frontend**: It is built on Flutter, which provides consistent high-performance user experiences across iOS and Android. 
- **Backend**: It is powered by Node.js, scalable and efficient server-side operation is ensured. 
- **Database:** Store User Information, Product details, Order details.
- **Integration of Payments**: Supports both Apple Pay and Google Pay, ensuring security and ease of transaction.  

This is an application that provides a very sound backbone for the ecommerce businesses, where administrators and end-users get usability, efficiency, and scalability altogether. Advanced analytics, recommendations, and improving delivery tracking will probably be added in future versions.

 Stack: 
   flutter: 
    cupertino_icons: ^1.0.2
    flutter_screenutil: ^5.9.3
    http: ^1.1.0
    provider: ^6.1.2
    shared_preferences: ^2.2.3
    badges: ^3.1.2
    carousel_slider: ^5.0.0
    dotted_border: ^2.1.0
    file_picker: ^8.0.0+1
    cloudinary_public: ^0.23.1
    permission_handler: ^11.0.1
    flutter_rating_bar: ^4.0.1
    pay: ^1.1.2
    intl: ^0.18.1
    fl_chart: ^0.60.0
   node js:
    "bcryptjs": "^2.4.3",
    "express": "^4.21.1",
    "http": "^0.0.1-security",
    "jsonwebtoken": "^9.0.2",
    "mongoose": "^8.7.2"
    
    
    

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
