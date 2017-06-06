<<<<<<< HEAD
module HL7
  class Message::Segment::FT1 < HL7::Message::Segment
    weight 10
    add_field :set_id
    add_field :transaction_id
    add_field :transaction_batch_id
    add_field :date_of_service do |value|
      convert_to_ts(value)
    end
    add_field :transaction_posting_date do |value|
      convert_to_ts(value)
    end
    add_field :transaction_type
    add_field :transaction_code
    add_field :transaction_description
    add_field :transaction_description_alt
    add_field :transaction_quantity
    add_field :transaction_amount_extended
    add_field :transaction_amount_unit
    add_field :department_code
    add_field :insurance_plan_id
    add_field :insurance_amount
    add_field :insurance_company_id
    add_field :insurance_company_name
    add_field :insurance_company_address
    add_field :insurance_company_contact_person
    add_field :assigned_patient_location
    add_field :fees_schedule
    add_field :patient_type

    # https://www.findacode.com/icd-9/icd-9-cm-diagnosis-codes.html
    # http://www.icd10data.com/ICD10CM/Codes
    add_field :diagnosis_code

    # https://en.wikipedia.org/wiki/National_Provider_Identifier
    add_field :performed_by_provider

    add_field :ordering_provider
    add_field :unit_cost
    add_field :filler_order_number
    add_field :entered_by

    # https://en.wikipedia.org/wiki/Current_Procedural_Terminology (CPT)
    add_field :procedure_code

    add_field :procedure_code_modifier
    add_field :advanced_beneficiary_notice_code
    add_field :medically_necessary_duplicate_procedure_reason
    add_field :ndc_code
    add_field :payment_reference_id
    add_field :transaction_reference_key
    add_field :performing_facility
    add_field :ordering_facility
    add_field :item_number
    add_field :model_number
    add_field :special_processing_code
    add_field :clinic_code
    add_field :referral_number
    add_field :authorization_number
    add_field :service_provider_taxonomy_code
    add_field :revenue_code
    add_field :prescription_number
    add_field :ndc_qty_and_uom

  end
end
=======
# encoding: UTF-8
# via https://github.com/bbhoss/ruby-hl7/blob/master/lib/segments/in1.rb
require 'ruby-hl7'
class HL7::Message::Segment::FT1 < HL7::Message::Segment
  add_field :set_id
  add_field :transaction_id
  add_field :transaction_batch
  add_field :transaction_date
  add_field :transaction_posting_date
  add_field :transaction_type
  add_field :transaction_code
  add_field :transaction_description
  add_field :transaction_description_alt
  add_field :transaction_quantity
  add_field :transaction_amount_extended
  add_field :transaction_amount_unit
  add_field :department_code
  add_field :insurance_plan_id
  add_field :insurance_amount
  add_field :assigned_patient_location
  add_field :fee_schedule
  add_field :patient_type
  add_field :diagnosis_code
  add_field :performed_by_code
  add_field :ordered_by_code
  add_field :unit_cost
  add_field :filter_order_number
  add_field :entered_by_code
  add_field :procedure_code
  add_field :procedure_code_modifier
  add_field :advanced_beneficiary_notice_code
  add_field :medically_necessary_duplicate_procedure_code
  add_field :ndc_code
  add_field :payment_reference_id
  add_field :transaction_reference_key
end
>>>>>>> adjusted weight for ft1
