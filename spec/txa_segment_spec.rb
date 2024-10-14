require "spec_helper"

describe HL7::Message::Segment::TXA do
  let(:segment) do
    "TXA|1|AR|AP|20220611113300|1^Name|20220611|2022061110||1^Creator|" \
      "1^Author|1^Typer|A^V02^UID^TC|A^V01^UID^TC|01|02|file.txt|C|P|AV|ST||" \
      "2022061110|DC|AR|FileName|202206111011"
  end
  let(:filled_txa) { HL7::Message::Segment::TXA.new segment }

  it "allows access to an TXA segment" do
    expect(filled_txa.set_id).to eq("1")
    expect(filled_txa.document_type).to eq("AR")
    expect(filled_txa.document_content_presentation).to eq("AP")
    expect(filled_txa.activity_date_time).to eq("20220611113300")
    expect(filled_txa.primary_activity_provider_code).to eq("1^Name")
    expect(filled_txa.origination_date_time).to eq("20220611")
    expect(filled_txa.transcription_date_time).to eq("2022061110")
    expect(filled_txa.edit_date_time).to eq("")
    expect(filled_txa.originator_code).to eq("1^Creator")
    expect(filled_txa.assigned_document_authenticator).to eq("1^Author")
    expect(filled_txa.transcriptionist_code).to eq("1^Typer")
    expect(filled_txa.unique_document_number).to eq("A^V02^UID^TC")
    expect(filled_txa.parent_document_number).to eq("A^V01^UID^TC")
    expect(filled_txa.placer_order_number).to eq("01")
    expect(filled_txa.filler_order_number).to eq("02")
    expect(filled_txa.unique_document_file_name).to eq("file.txt")
    expect(filled_txa.document_completion_status).to eq("C")
    expect(filled_txa.document_confidentiality_status).to eq("P")
    expect(filled_txa.document_availability_status).to eq("AV")
    expect(filled_txa.document_storage_status).to eq("ST")
    expect(filled_txa.document_change_reason).to eq("")
    expect(filled_txa.authentication_person_time_stamp).to eq("2022061110")
    expect(filled_txa.distributed_copies_code).to eq("DC")
    expect(filled_txa.folder_assignment).to eq("AR")
    expect(filled_txa.document_title).to eq("FileName")
    expect(filled_txa.agreed_due_date_time).to eq("202206111011")
  end

  it "allows creation of an TXA segment" do
    txa = HL7::Message::Segment::TXA.new
    txa.set_id = "1"
    txa.document_type = "AR"
    txa.document_content_presentation = "AP"
    txa.activity_date_time = "20220611113300"
    txa.primary_activity_provider_code = "1^Name"
    txa.origination_date_time = "20220611"
    txa.transcription_date_time = "2022061110"
    txa.edit_date_time = ""
    txa.originator_code = "1^Creator"
    txa.assigned_document_authenticator = "1^Author"
    txa.transcriptionist_code = "1^Typer"
    txa.unique_document_number = "A^V02^UID^TC"
    txa.parent_document_number = "A^V01^UID^TC"
    txa.placer_order_number = "01"
    txa.filler_order_number = "02"
    txa.unique_document_file_name = "file.txt"
    txa.document_completion_status = "C"
    txa.document_confidentiality_status = "P"
    txa.document_availability_status = "AV"
    txa.document_storage_status = "ST"
    txa.document_change_reason = ""
    txa.authentication_person_time_stamp = "2022061110"
    txa.distributed_copies_code = "DC"
    txa.folder_assignment = "AR"
    txa.document_title = "FileName"
    txa.agreed_due_date_time = "202206111011"

    expect(txa.to_s).to eq(segment)
  end
end
