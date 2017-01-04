# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150326180847) do

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "spree_activators", force: true do |t|
    t.string   "description"
    t.datetime "expires_at"
    t.datetime "starts_at"
    t.string   "name"
    t.string   "event_name"
    t.string   "type"
    t.integer  "usage_limit"
    t.string   "match_policy", default: "all"
    t.string   "code"
    t.boolean  "advertise",    default: false
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_addresses", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "zipcode"
    t.string   "phone"
    t.string   "state_name"
    t.string   "alternative_phone"
    t.string   "company"
    t.integer  "state_id"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "spree_addresses", ["country_id"], name: "index_spree_addresses_on_country_id"
  add_index "spree_addresses", ["firstname"], name: "index_addresses_on_firstname"
  add_index "spree_addresses", ["lastname"], name: "index_addresses_on_lastname"
  add_index "spree_addresses", ["state_id"], name: "index_spree_addresses_on_state_id"
  add_index "spree_addresses", ["user_id"], name: "index_spree_addresses_on_user_id"

  create_table "spree_adjustments", force: true do |t|
    t.integer  "source_id"
    t.string   "source_type"
    t.integer  "adjustable_id"
    t.string   "adjustable_type"
    t.decimal  "amount",          precision: 10, scale: 2
    t.string   "label"
    t.boolean  "mandatory"
    t.boolean  "eligible",                                 default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.integer  "order_id"
    t.boolean  "included",                                 default: false
  end

  add_index "spree_adjustments", ["adjustable_id", "adjustable_type"], name: "index_spree_adjustments_on_adjustable_id_and_adjustable_type"
  add_index "spree_adjustments", ["adjustable_id"], name: "index_adjustments_on_order_id"
  add_index "spree_adjustments", ["eligible"], name: "index_spree_adjustments_on_eligible"
  add_index "spree_adjustments", ["order_id"], name: "index_spree_adjustments_on_order_id"
  add_index "spree_adjustments", ["source_id", "source_type"], name: "index_spree_adjustments_on_source_id_and_source_type"

  create_table "spree_assets", force: true do |t|
    t.integer  "viewable_id"
    t.string   "viewable_type"
    t.integer  "attachment_width"
    t.integer  "attachment_height"
    t.integer  "attachment_file_size"
    t.integer  "position"
    t.string   "attachment_content_type"
    t.string   "attachment_file_name"
    t.string   "type",                    limit: 75
    t.datetime "attachment_updated_at"
    t.text     "alt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_assets", ["viewable_id"], name: "index_assets_on_viewable_id"
  add_index "spree_assets", ["viewable_type", "type"], name: "index_assets_on_viewable_type_and_type"

  create_table "spree_calculators", force: true do |t|
    t.string   "type"
    t.integer  "calculable_id"
    t.string   "calculable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "preferences"
  end

  add_index "spree_calculators", ["calculable_id", "calculable_type"], name: "index_spree_calculators_on_calculable_id_and_calculable_type"
  add_index "spree_calculators", ["id", "type"], name: "index_spree_calculators_on_id_and_type"

  create_table "spree_chimpy_order_sources", force: true do |t|
    t.integer  "order_id"
    t.string   "campaign_id"
    t.string   "email_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_chimpy_subscribers", force: true do |t|
    t.string   "email",                     null: false
    t.boolean  "subscribed", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_configurations", force: true do |t|
    t.string   "name"
    t.string   "type",       limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_configurations", ["name", "type"], name: "index_spree_configurations_on_name_and_type"

  create_table "spree_countries", force: true do |t|
    t.string   "iso_name"
    t.string   "iso"
    t.string   "iso3"
    t.string   "name"
    t.integer  "numcode"
    t.boolean  "states_required", default: false
    t.datetime "updated_at"
  end

  create_table "spree_credit_cards", force: true do |t|
    t.string   "month"
    t.string   "year"
    t.string   "cc_type"
    t.string   "last_digits"
    t.integer  "address_id"
    t.string   "gateway_customer_profile_id"
    t.string   "gateway_payment_profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "user_id"
    t.integer  "payment_method_id"
    t.boolean  "default",                     default: false, null: false
  end

  add_index "spree_credit_cards", ["address_id"], name: "index_spree_credit_cards_on_address_id"
  add_index "spree_credit_cards", ["payment_method_id"], name: "index_spree_credit_cards_on_payment_method_id"
  add_index "spree_credit_cards", ["user_id"], name: "index_spree_credit_cards_on_user_id"

  create_table "spree_customer_returns", force: true do |t|
    t.string   "number"
    t.integer  "stock_location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_gateways", force: true do |t|
    t.string   "type"
    t.string   "name"
    t.text     "description"
    t.boolean  "active",      default: true
    t.string   "environment", default: "development"
    t.string   "server",      default: "test"
    t.boolean  "test_mode",   default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "preferences"
  end

  add_index "spree_gateways", ["active"], name: "index_spree_gateways_on_active"
  add_index "spree_gateways", ["test_mode"], name: "index_spree_gateways_on_test_mode"

  create_table "spree_inventory_units", force: true do |t|
    t.string   "state"
    t.integer  "variant_id"
    t.integer  "order_id"
    t.integer  "shipment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "pending",      default: true
    t.integer  "line_item_id"
  end

  add_index "spree_inventory_units", ["line_item_id"], name: "index_spree_inventory_units_on_line_item_id"
  add_index "spree_inventory_units", ["order_id"], name: "index_inventory_units_on_order_id"
  add_index "spree_inventory_units", ["shipment_id"], name: "index_inventory_units_on_shipment_id"
  add_index "spree_inventory_units", ["variant_id"], name: "index_inventory_units_on_variant_id"

  create_table "spree_line_items", force: true do |t|
    t.integer  "variant_id"
    t.integer  "order_id"
    t.integer  "quantity",                                                    null: false
    t.decimal  "price",                precision: 10, scale: 2,               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "currency"
    t.decimal  "cost_price",           precision: 10, scale: 2
    t.integer  "tax_category_id"
    t.decimal  "adjustment_total",     precision: 10, scale: 2, default: 0.0
    t.decimal  "additional_tax_total", precision: 10, scale: 2, default: 0.0
    t.decimal  "promo_total",          precision: 10, scale: 2, default: 0.0
    t.decimal  "included_tax_total",   precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "pre_tax_amount",       precision: 8,  scale: 2, default: 0.0
  end

  add_index "spree_line_items", ["order_id"], name: "index_spree_line_items_on_order_id"
  add_index "spree_line_items", ["tax_category_id"], name: "index_spree_line_items_on_tax_category_id"
  add_index "spree_line_items", ["variant_id"], name: "index_spree_line_items_on_variant_id"

  create_table "spree_log_entries", force: true do |t|
    t.integer  "source_id"
    t.string   "source_type"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_log_entries", ["source_id", "source_type"], name: "index_spree_log_entries_on_source_id_and_source_type"

  create_table "spree_mail_methods", force: true do |t|
    t.string   "environment"
    t.boolean  "active",      default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_option_types", force: true do |t|
    t.string   "name",         limit: 100
    t.string   "presentation", limit: 100
    t.integer  "position",                 default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_option_types", ["position"], name: "index_spree_option_types_on_position"

  create_table "spree_option_types_prototypes", id: false, force: true do |t|
    t.integer "prototype_id"
    t.integer "option_type_id"
  end

  create_table "spree_option_values", force: true do |t|
    t.integer  "position"
    t.string   "name"
    t.string   "presentation"
    t.integer  "option_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_option_values", ["option_type_id"], name: "index_spree_option_values_on_option_type_id"
  add_index "spree_option_values", ["position"], name: "index_spree_option_values_on_position"

  create_table "spree_option_values_variants", id: false, force: true do |t|
    t.integer "variant_id"
    t.integer "option_value_id"
  end

  add_index "spree_option_values_variants", ["variant_id", "option_value_id"], name: "index_option_values_variants_on_variant_id_and_option_value_id"
  add_index "spree_option_values_variants", ["variant_id"], name: "index_spree_option_values_variants_on_variant_id"

  create_table "spree_orders", force: true do |t|
    t.string   "number",                 limit: 32
    t.decimal  "item_total",                        precision: 10, scale: 2, default: 0.0,     null: false
    t.decimal  "total",                             precision: 10, scale: 2, default: 0.0,     null: false
    t.string   "state"
    t.decimal  "adjustment_total",                  precision: 10, scale: 2, default: 0.0,     null: false
    t.integer  "user_id"
    t.datetime "completed_at"
    t.integer  "bill_address_id"
    t.integer  "ship_address_id"
    t.decimal  "payment_total",                     precision: 10, scale: 2, default: 0.0
    t.integer  "shipping_method_id"
    t.string   "shipment_state"
    t.string   "payment_state"
    t.string   "email"
    t.text     "special_instructions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "currency"
    t.string   "last_ip_address"
    t.integer  "created_by_id"
    t.decimal  "shipment_total",                    precision: 10, scale: 2, default: 0.0,     null: false
    t.decimal  "additional_tax_total",              precision: 10, scale: 2, default: 0.0
    t.decimal  "promo_total",                       precision: 10, scale: 2, default: 0.0
    t.string   "channel",                                                    default: "spree"
    t.decimal  "included_tax_total",                precision: 10, scale: 2, default: 0.0,     null: false
    t.integer  "item_count",                                                 default: 0
    t.integer  "approver_id"
    t.datetime "approved_at"
    t.boolean  "confirmation_delivered",                                     default: false
    t.boolean  "considered_risky",                                           default: false
    t.string   "guest_token"
    t.datetime "canceled_at"
    t.integer  "canceler_id"
    t.integer  "store_id"
    t.integer  "state_lock_version",                                         default: 0,       null: false
  end

  add_index "spree_orders", ["approver_id"], name: "index_spree_orders_on_approver_id"
  add_index "spree_orders", ["bill_address_id"], name: "index_spree_orders_on_bill_address_id"
  add_index "spree_orders", ["completed_at"], name: "index_spree_orders_on_completed_at"
  add_index "spree_orders", ["confirmation_delivered"], name: "index_spree_orders_on_confirmation_delivered"
  add_index "spree_orders", ["considered_risky"], name: "index_spree_orders_on_considered_risky"
  add_index "spree_orders", ["created_by_id"], name: "index_spree_orders_on_created_by_id"
  add_index "spree_orders", ["guest_token"], name: "index_spree_orders_on_guest_token"
  add_index "spree_orders", ["number"], name: "index_spree_orders_on_number"
  add_index "spree_orders", ["ship_address_id"], name: "index_spree_orders_on_ship_address_id"
  add_index "spree_orders", ["shipping_method_id"], name: "index_spree_orders_on_shipping_method_id"
  add_index "spree_orders", ["user_id", "created_by_id"], name: "index_spree_orders_on_user_id_and_created_by_id"
  add_index "spree_orders", ["user_id"], name: "index_spree_orders_on_user_id"

  create_table "spree_orders_promotions", id: false, force: true do |t|
    t.integer "order_id"
    t.integer "promotion_id"
  end

  add_index "spree_orders_promotions", ["order_id", "promotion_id"], name: "index_spree_orders_promotions_on_order_id_and_promotion_id"

  create_table "spree_payment_capture_events", force: true do |t|
    t.decimal  "amount",     precision: 10, scale: 2, default: 0.0
    t.integer  "payment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_payment_capture_events", ["payment_id"], name: "index_spree_payment_capture_events_on_payment_id"

  create_table "spree_payment_methods", force: true do |t|
    t.string   "type"
    t.string   "name"
    t.text     "description"
    t.boolean  "active",       default: true
    t.string   "environment",  default: "development"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_on"
    t.boolean  "auto_capture"
    t.text     "preferences"
  end

  add_index "spree_payment_methods", ["id", "type"], name: "index_spree_payment_methods_on_id_and_type"

  create_table "spree_payments", force: true do |t|
    t.decimal  "amount",               precision: 10, scale: 2, default: 0.0, null: false
    t.integer  "order_id"
    t.integer  "source_id"
    t.string   "source_type"
    t.integer  "payment_method_id"
    t.string   "state"
    t.string   "response_code"
    t.string   "avs_response"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "identifier"
    t.string   "cvv_response_code"
    t.string   "cvv_response_message"
  end

  add_index "spree_payments", ["order_id"], name: "index_spree_payments_on_order_id"
  add_index "spree_payments", ["payment_method_id"], name: "index_spree_payments_on_payment_method_id"
  add_index "spree_payments", ["source_id", "source_type"], name: "index_spree_payments_on_source_id_and_source_type"

  create_table "spree_preferences", force: true do |t|
    t.text     "value"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_preferences", ["key"], name: "index_spree_preferences_on_key", unique: true

  create_table "spree_prices", force: true do |t|
    t.integer  "variant_id",                          null: false
    t.decimal  "amount",     precision: 10, scale: 2
    t.string   "currency"
    t.datetime "deleted_at"
  end

  add_index "spree_prices", ["deleted_at"], name: "index_spree_prices_on_deleted_at"
  add_index "spree_prices", ["variant_id", "currency"], name: "index_spree_prices_on_variant_id_and_currency"

  create_table "spree_product_option_types", force: true do |t|
    t.integer  "position"
    t.integer  "product_id"
    t.integer  "option_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_product_option_types", ["option_type_id"], name: "index_spree_product_option_types_on_option_type_id"
  add_index "spree_product_option_types", ["position"], name: "index_spree_product_option_types_on_position"
  add_index "spree_product_option_types", ["product_id"], name: "index_spree_product_option_types_on_product_id"

  create_table "spree_product_properties", force: true do |t|
    t.string   "value"
    t.integer  "product_id"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",    default: 0
  end

  add_index "spree_product_properties", ["position"], name: "index_spree_product_properties_on_position"
  add_index "spree_product_properties", ["product_id"], name: "index_product_properties_on_product_id"
  add_index "spree_product_properties", ["property_id"], name: "index_spree_product_properties_on_property_id"

  create_table "spree_products", force: true do |t|
    t.string   "name",                 default: "",   null: false
    t.text     "description"
    t.datetime "available_on"
    t.datetime "deleted_at"
    t.string   "slug"
    t.text     "meta_description"
    t.string   "meta_keywords"
    t.integer  "tax_category_id"
    t.integer  "shipping_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "promotionable",        default: true
    t.string   "meta_title"
  end

  add_index "spree_products", ["available_on"], name: "index_spree_products_on_available_on"
  add_index "spree_products", ["deleted_at"], name: "index_spree_products_on_deleted_at"
  add_index "spree_products", ["name"], name: "index_spree_products_on_name"
  add_index "spree_products", ["shipping_category_id"], name: "index_spree_products_on_shipping_category_id"
  add_index "spree_products", ["slug"], name: "index_spree_products_on_slug"
  add_index "spree_products", ["slug"], name: "permalink_idx_unique", unique: true
  add_index "spree_products", ["tax_category_id"], name: "index_spree_products_on_tax_category_id"

  create_table "spree_products_promotion_rules", id: false, force: true do |t|
    t.integer "product_id"
    t.integer "promotion_rule_id"
  end

  add_index "spree_products_promotion_rules", ["product_id"], name: "index_products_promotion_rules_on_product_id"
  add_index "spree_products_promotion_rules", ["promotion_rule_id"], name: "index_products_promotion_rules_on_promotion_rule_id"

  create_table "spree_products_taxons", force: true do |t|
    t.integer "product_id"
    t.integer "taxon_id"
    t.integer "position"
  end

  add_index "spree_products_taxons", ["position"], name: "index_spree_products_taxons_on_position"
  add_index "spree_products_taxons", ["product_id"], name: "index_spree_products_taxons_on_product_id"
  add_index "spree_products_taxons", ["taxon_id"], name: "index_spree_products_taxons_on_taxon_id"

  create_table "spree_promotion_action_line_items", force: true do |t|
    t.integer "promotion_action_id"
    t.integer "variant_id"
    t.integer "quantity",            default: 1
  end

  add_index "spree_promotion_action_line_items", ["promotion_action_id"], name: "index_spree_promotion_action_line_items_on_promotion_action_id"
  add_index "spree_promotion_action_line_items", ["variant_id"], name: "index_spree_promotion_action_line_items_on_variant_id"

  create_table "spree_promotion_actions", force: true do |t|
    t.integer  "promotion_id"
    t.integer  "position"
    t.string   "type"
    t.datetime "deleted_at"
  end

  add_index "spree_promotion_actions", ["deleted_at"], name: "index_spree_promotion_actions_on_deleted_at"
  add_index "spree_promotion_actions", ["id", "type"], name: "index_spree_promotion_actions_on_id_and_type"
  add_index "spree_promotion_actions", ["promotion_id"], name: "index_spree_promotion_actions_on_promotion_id"

  create_table "spree_promotion_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_promotion_rules", force: true do |t|
    t.integer  "promotion_id"
    t.integer  "user_id"
    t.integer  "product_group_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
    t.text     "preferences"
  end

  add_index "spree_promotion_rules", ["product_group_id"], name: "index_promotion_rules_on_product_group_id"
  add_index "spree_promotion_rules", ["promotion_id"], name: "index_spree_promotion_rules_on_promotion_id"
  add_index "spree_promotion_rules", ["user_id"], name: "index_promotion_rules_on_user_id"

  create_table "spree_promotion_rules_users", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "promotion_rule_id"
  end

  add_index "spree_promotion_rules_users", ["promotion_rule_id"], name: "index_promotion_rules_users_on_promotion_rule_id"
  add_index "spree_promotion_rules_users", ["user_id"], name: "index_promotion_rules_users_on_user_id"

  create_table "spree_promotions", force: true do |t|
    t.string   "description"
    t.datetime "expires_at"
    t.datetime "starts_at"
    t.string   "name"
    t.string   "type"
    t.integer  "usage_limit"
    t.string   "match_policy",          default: "all"
    t.string   "code"
    t.boolean  "advertise",             default: false
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "promotion_category_id"
  end

  add_index "spree_promotions", ["advertise"], name: "index_spree_promotions_on_advertise"
  add_index "spree_promotions", ["code"], name: "index_spree_promotions_on_code"
  add_index "spree_promotions", ["expires_at"], name: "index_spree_promotions_on_expires_at"
  add_index "spree_promotions", ["id", "type"], name: "index_spree_promotions_on_id_and_type"
  add_index "spree_promotions", ["promotion_category_id"], name: "index_spree_promotions_on_promotion_category_id"
  add_index "spree_promotions", ["starts_at"], name: "index_spree_promotions_on_starts_at"

  create_table "spree_properties", force: true do |t|
    t.string   "name"
    t.string   "presentation", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_properties_prototypes", id: false, force: true do |t|
    t.integer "prototype_id"
    t.integer "property_id"
  end

  create_table "spree_prototypes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_refund_reasons", force: true do |t|
    t.string   "name"
    t.boolean  "active",     default: true
    t.boolean  "mutable",    default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_refunds", force: true do |t|
    t.integer  "payment_id"
    t.decimal  "amount",           precision: 10, scale: 2, default: 0.0, null: false
    t.string   "transaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "refund_reason_id"
    t.integer  "reimbursement_id"
  end

  add_index "spree_refunds", ["refund_reason_id"], name: "index_refunds_on_refund_reason_id"

  create_table "spree_reimbursement_credits", force: true do |t|
    t.decimal "amount",           precision: 10, scale: 2, default: 0.0, null: false
    t.integer "reimbursement_id"
    t.integer "creditable_id"
    t.string  "creditable_type"
  end

  create_table "spree_reimbursement_types", force: true do |t|
    t.string   "name"
    t.boolean  "active",     default: true
    t.boolean  "mutable",    default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  add_index "spree_reimbursement_types", ["type"], name: "index_spree_reimbursement_types_on_type"

  create_table "spree_reimbursements", force: true do |t|
    t.string   "number"
    t.string   "reimbursement_status"
    t.integer  "customer_return_id"
    t.integer  "order_id"
    t.decimal  "total",                precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_reimbursements", ["customer_return_id"], name: "index_spree_reimbursements_on_customer_return_id"
  add_index "spree_reimbursements", ["order_id"], name: "index_spree_reimbursements_on_order_id"

  create_table "spree_return_authorization_reasons", force: true do |t|
    t.string   "name"
    t.boolean  "active",     default: true
    t.boolean  "mutable",    default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_return_authorizations", force: true do |t|
    t.string   "number"
    t.string   "state"
    t.integer  "order_id"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stock_location_id"
    t.integer  "return_authorization_reason_id"
  end

  add_index "spree_return_authorizations", ["return_authorization_reason_id"], name: "index_return_authorizations_on_return_authorization_reason_id"

  create_table "spree_return_items", force: true do |t|
    t.integer  "return_authorization_id"
    t.integer  "inventory_unit_id"
    t.integer  "exchange_variant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "pre_tax_amount",                  precision: 12, scale: 4, default: 0.0, null: false
    t.decimal  "included_tax_total",              precision: 12, scale: 4, default: 0.0, null: false
    t.decimal  "additional_tax_total",            precision: 12, scale: 4, default: 0.0, null: false
    t.string   "reception_status"
    t.string   "acceptance_status"
    t.integer  "customer_return_id"
    t.integer  "reimbursement_id"
    t.integer  "exchange_inventory_unit_id"
    t.text     "acceptance_status_errors"
    t.integer  "preferred_reimbursement_type_id"
    t.integer  "override_reimbursement_type_id"
  end

  add_index "spree_return_items", ["customer_return_id"], name: "index_return_items_on_customer_return_id"
  add_index "spree_return_items", ["exchange_inventory_unit_id"], name: "index_spree_return_items_on_exchange_inventory_unit_id"

  create_table "spree_roles", force: true do |t|
    t.string "name"
  end

  create_table "spree_roles_users", id: false, force: true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "spree_roles_users", ["role_id"], name: "index_spree_roles_users_on_role_id"
  add_index "spree_roles_users", ["user_id"], name: "index_spree_roles_users_on_user_id"

  create_table "spree_shipments", force: true do |t|
    t.string   "tracking"
    t.string   "number"
    t.decimal  "cost",                 precision: 10, scale: 2, default: 0.0
    t.datetime "shipped_at"
    t.integer  "order_id"
    t.integer  "address_id"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stock_location_id"
    t.decimal  "adjustment_total",     precision: 10, scale: 2, default: 0.0
    t.decimal  "additional_tax_total", precision: 10, scale: 2, default: 0.0
    t.decimal  "promo_total",          precision: 10, scale: 2, default: 0.0
    t.decimal  "included_tax_total",   precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "pre_tax_amount",       precision: 8,  scale: 2, default: 0.0
  end

  add_index "spree_shipments", ["address_id"], name: "index_spree_shipments_on_address_id"
  add_index "spree_shipments", ["number"], name: "index_shipments_on_number"
  add_index "spree_shipments", ["order_id"], name: "index_spree_shipments_on_order_id"
  add_index "spree_shipments", ["stock_location_id"], name: "index_spree_shipments_on_stock_location_id"

  create_table "spree_shipping_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_shipping_method_categories", force: true do |t|
    t.integer  "shipping_method_id",   null: false
    t.integer  "shipping_category_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_shipping_method_categories", ["shipping_category_id", "shipping_method_id"], name: "unique_spree_shipping_method_categories", unique: true
  add_index "spree_shipping_method_categories", ["shipping_method_id"], name: "index_spree_shipping_method_categories_on_shipping_method_id"

  create_table "spree_shipping_methods", force: true do |t|
    t.string   "name"
    t.string   "display_on"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tracking_url"
    t.string   "admin_name"
    t.integer  "tax_category_id"
    t.string   "code"
  end

  add_index "spree_shipping_methods", ["deleted_at"], name: "index_spree_shipping_methods_on_deleted_at"
  add_index "spree_shipping_methods", ["tax_category_id"], name: "index_spree_shipping_methods_on_tax_category_id"

  create_table "spree_shipping_methods_zones", id: false, force: true do |t|
    t.integer "shipping_method_id"
    t.integer "zone_id"
  end

  create_table "spree_shipping_rates", force: true do |t|
    t.integer  "shipment_id"
    t.integer  "shipping_method_id"
    t.boolean  "selected",                                   default: false
    t.decimal  "cost",               precision: 8, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tax_rate_id"
  end

  add_index "spree_shipping_rates", ["selected"], name: "index_spree_shipping_rates_on_selected"
  add_index "spree_shipping_rates", ["shipment_id", "shipping_method_id"], name: "spree_shipping_rates_join_index", unique: true
  add_index "spree_shipping_rates", ["tax_rate_id"], name: "index_spree_shipping_rates_on_tax_rate_id"

  create_table "spree_skrill_transactions", force: true do |t|
    t.string   "email"
    t.float    "amount"
    t.string   "currency"
    t.integer  "transaction_id"
    t.integer  "customer_id"
    t.string   "payment_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_state_changes", force: true do |t|
    t.string   "name"
    t.string   "previous_state"
    t.integer  "stateful_id"
    t.integer  "user_id"
    t.string   "stateful_type"
    t.string   "next_state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_state_changes", ["stateful_id", "stateful_type"], name: "index_spree_state_changes_on_stateful_id_and_stateful_type"
  add_index "spree_state_changes", ["user_id"], name: "index_spree_state_changes_on_user_id"

  create_table "spree_states", force: true do |t|
    t.string   "name"
    t.string   "abbr"
    t.integer  "country_id"
    t.datetime "updated_at"
  end

  add_index "spree_states", ["country_id"], name: "index_spree_states_on_country_id"

  create_table "spree_stock_items", force: true do |t|
    t.integer  "stock_location_id"
    t.integer  "variant_id"
    t.integer  "count_on_hand",     default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "backorderable",     default: false
    t.datetime "deleted_at"
  end

  add_index "spree_stock_items", ["backorderable"], name: "index_spree_stock_items_on_backorderable"
  add_index "spree_stock_items", ["deleted_at"], name: "index_spree_stock_items_on_deleted_at"
  add_index "spree_stock_items", ["stock_location_id", "variant_id"], name: "stock_item_by_loc_and_var_id"
  add_index "spree_stock_items", ["stock_location_id"], name: "index_spree_stock_items_on_stock_location_id"

  create_table "spree_stock_locations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.integer  "state_id"
    t.string   "state_name"
    t.integer  "country_id"
    t.string   "zipcode"
    t.string   "phone"
    t.boolean  "active",                 default: true
    t.boolean  "backorderable_default",  default: false
    t.boolean  "propagate_all_variants", default: true
    t.string   "admin_name"
    t.boolean  "default",                default: false, null: false
  end

  add_index "spree_stock_locations", ["active"], name: "index_spree_stock_locations_on_active"
  add_index "spree_stock_locations", ["backorderable_default"], name: "index_spree_stock_locations_on_backorderable_default"
  add_index "spree_stock_locations", ["country_id"], name: "index_spree_stock_locations_on_country_id"
  add_index "spree_stock_locations", ["propagate_all_variants"], name: "index_spree_stock_locations_on_propagate_all_variants"
  add_index "spree_stock_locations", ["state_id"], name: "index_spree_stock_locations_on_state_id"

  create_table "spree_stock_movements", force: true do |t|
    t.integer  "stock_item_id"
    t.integer  "quantity",        default: 0
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "originator_id"
    t.string   "originator_type"
  end

  add_index "spree_stock_movements", ["stock_item_id"], name: "index_spree_stock_movements_on_stock_item_id"

  create_table "spree_stock_transfers", force: true do |t|
    t.string   "type"
    t.string   "reference"
    t.integer  "source_location_id"
    t.integer  "destination_location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "number"
  end

  add_index "spree_stock_transfers", ["destination_location_id"], name: "index_spree_stock_transfers_on_destination_location_id"
  add_index "spree_stock_transfers", ["number"], name: "index_spree_stock_transfers_on_number"
  add_index "spree_stock_transfers", ["source_location_id"], name: "index_spree_stock_transfers_on_source_location_id"

  create_table "spree_stores", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.text     "meta_description"
    t.text     "meta_keywords"
    t.string   "seo_title"
    t.string   "mail_from_address"
    t.string   "default_currency"
    t.string   "code"
    t.boolean  "default",           default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_stores", ["code"], name: "index_spree_stores_on_code"
  add_index "spree_stores", ["default"], name: "index_spree_stores_on_default"
  add_index "spree_stores", ["url"], name: "index_spree_stores_on_url"

  create_table "spree_tax_categories", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "is_default",  default: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tax_code"
  end

  add_index "spree_tax_categories", ["deleted_at"], name: "index_spree_tax_categories_on_deleted_at"
  add_index "spree_tax_categories", ["is_default"], name: "index_spree_tax_categories_on_is_default"

  create_table "spree_tax_rates", force: true do |t|
    t.decimal  "amount",             precision: 8, scale: 5
    t.integer  "zone_id"
    t.integer  "tax_category_id"
    t.boolean  "included_in_price",                          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "show_rate_in_label",                         default: true
    t.datetime "deleted_at"
  end

  add_index "spree_tax_rates", ["deleted_at"], name: "index_spree_tax_rates_on_deleted_at"
  add_index "spree_tax_rates", ["included_in_price"], name: "index_spree_tax_rates_on_included_in_price"
  add_index "spree_tax_rates", ["show_rate_in_label"], name: "index_spree_tax_rates_on_show_rate_in_label"
  add_index "spree_tax_rates", ["tax_category_id"], name: "index_spree_tax_rates_on_tax_category_id"
  add_index "spree_tax_rates", ["zone_id"], name: "index_spree_tax_rates_on_zone_id"

  create_table "spree_taxonomies", force: true do |t|
    t.string   "name",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",   default: 0
  end

  add_index "spree_taxonomies", ["position"], name: "index_spree_taxonomies_on_position"

  create_table "spree_taxons", force: true do |t|
    t.integer  "parent_id"
    t.integer  "position",          default: 0
    t.string   "name",                          null: false
    t.string   "permalink"
    t.integer  "taxonomy_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "meta_title"
    t.string   "meta_description"
    t.string   "meta_keywords"
    t.integer  "depth"
  end

  add_index "spree_taxons", ["parent_id"], name: "index_taxons_on_parent_id"
  add_index "spree_taxons", ["permalink"], name: "index_taxons_on_permalink"
  add_index "spree_taxons", ["position"], name: "index_spree_taxons_on_position"
  add_index "spree_taxons", ["taxonomy_id"], name: "index_taxons_on_taxonomy_id"

  create_table "spree_taxons_promotion_rules", force: true do |t|
    t.integer "taxon_id"
    t.integer "promotion_rule_id"
  end

  add_index "spree_taxons_promotion_rules", ["promotion_rule_id"], name: "index_spree_taxons_promotion_rules_on_promotion_rule_id"
  add_index "spree_taxons_promotion_rules", ["taxon_id"], name: "index_spree_taxons_promotion_rules_on_taxon_id"

  create_table "spree_taxons_prototypes", force: true do |t|
    t.integer "taxon_id"
    t.integer "prototype_id"
  end

  add_index "spree_taxons_prototypes", ["prototype_id"], name: "index_spree_taxons_prototypes_on_prototype_id"
  add_index "spree_taxons_prototypes", ["taxon_id"], name: "index_spree_taxons_prototypes_on_taxon_id"

  create_table "spree_tokenized_permissions", force: true do |t|
    t.integer  "permissable_id"
    t.string   "permissable_type"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_tokenized_permissions", ["permissable_id", "permissable_type"], name: "index_tokenized_name_and_type"

  create_table "spree_trackers", force: true do |t|
    t.string   "environment"
    t.string   "analytics_id"
    t.boolean  "active",       default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_trackers", ["active"], name: "index_spree_trackers_on_active"

  create_table "spree_users", force: true do |t|
    t.string   "encrypted_password",     limit: 128
    t.string   "password_salt",          limit: 128
    t.string   "email"
    t.string   "remember_token"
    t.string   "persistence_token"
    t.string   "reset_password_token"
    t.string   "perishable_token"
    t.integer  "sign_in_count",                      default: 0, null: false
    t.integer  "failed_attempts",                    default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "login"
    t.integer  "ship_address_id"
    t.integer  "bill_address_id"
    t.string   "authentication_token"
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "subscribed"
    t.string   "spree_api_key",          limit: 48
    t.datetime "remember_created_at"
    t.datetime "deleted_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "spree_users", ["deleted_at"], name: "index_spree_users_on_deleted_at"
  add_index "spree_users", ["email"], name: "email_idx_unique", unique: true
  add_index "spree_users", ["spree_api_key"], name: "index_spree_users_on_spree_api_key"

  create_table "spree_variants", force: true do |t|
    t.string   "sku",                                        default: "",    null: false
    t.decimal  "weight",            precision: 8,  scale: 2, default: 0.0
    t.decimal  "height",            precision: 8,  scale: 2
    t.decimal  "width",             precision: 8,  scale: 2
    t.decimal  "depth",             precision: 8,  scale: 2
    t.datetime "deleted_at"
    t.boolean  "is_master",                                  default: false
    t.integer  "product_id"
    t.decimal  "cost_price",        precision: 10, scale: 2
    t.integer  "position"
    t.string   "cost_currency"
    t.boolean  "track_inventory",                            default: true
    t.integer  "tax_category_id"
    t.datetime "updated_at"
    t.integer  "stock_items_count",                          default: 0,     null: false
  end

  add_index "spree_variants", ["deleted_at"], name: "index_spree_variants_on_deleted_at"
  add_index "spree_variants", ["is_master"], name: "index_spree_variants_on_is_master"
  add_index "spree_variants", ["position"], name: "index_spree_variants_on_position"
  add_index "spree_variants", ["product_id"], name: "index_spree_variants_on_product_id"
  add_index "spree_variants", ["sku"], name: "index_spree_variants_on_sku"
  add_index "spree_variants", ["tax_category_id"], name: "index_spree_variants_on_tax_category_id"
  add_index "spree_variants", ["track_inventory"], name: "index_spree_variants_on_track_inventory"

  create_table "spree_zone_members", force: true do |t|
    t.integer  "zoneable_id"
    t.string   "zoneable_type"
    t.integer  "zone_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_zone_members", ["zone_id"], name: "index_spree_zone_members_on_zone_id"
  add_index "spree_zone_members", ["zoneable_id", "zoneable_type"], name: "index_spree_zone_members_on_zoneable_id_and_zoneable_type"

  create_table "spree_zones", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "default_tax",        default: false
    t.integer  "zone_members_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_zones", ["default_tax"], name: "index_spree_zones_on_default_tax"

end
