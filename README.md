# README


* Ruby version: 2.5.3

* Rails version: 5.2.4

* Deployment instructions:

<code>git clone git@github.com:madelynrr/rails_engine.git</code>

Enter the new directory and bundle install.

<code>rake db:create</code>

<code>rake db:migrate</>

Import data from the CSVs:

<code>rake db:customers</code>

<code>rake db:merchants</code>

<code>rake db:items</code>

<code>rake db:invoices</code>

<code>rake db:transactions</code>

<code>rake db:invoice_items</code>


Visit your local host to run endpoints and return data sets.


Rails Engine allows for access to our ecommerce site data. It returns resources based on all attributes, relationships, and various business statistics.
