class Patient {
  //id must not be final in order for index to be pushed to next screen
  String? id;
  //String? yesAdvancedAssessment;
  String? ptSpecialty;
  String? alertsDropId;
  String? allergiesRadio;
  String? attendingMDField;
  String? consultMDField;
  String? specialistsField;
  String? obgynField;
  String? codeStatusDrop;
  String? culturalDrop;
  String? dietDrop;
  String? fontanelDrop;
  String? fundalDrop;
  String? lochiaDrop;
  String? ambuDrop;
  String? teleDrop;
  String? genderDrop;
  String? pronounDrop;
  String? nicknameField;
  String? ageField;
  // String? ageInt;
  String? babyAgeField;
  String? babyWeightCommentField;
  String? babyNicknameField;
  String? securityBandField;
  String? patientAllergiesField;
  String? roomNumberField;
  String? genderRadio;
  String? babySexRadio;
  String? stickyNoteAssessmentField;
  String? labValuesField;
  String? weightField;
  String? heightField;
  String? measureCommentField;
  String? culturalCommentField;
  String? visitationCommentField;
  String? dxCommentField;
  String? dxInfCommentField;
  String? sdxCommentField;
  String? legalCommentField;
  String? alertsCommentField;
  String? neuroCommentField;
  String? camICUCommentField;
  String? rassCommentField;
  String? pupilsCommentField;
  String? sedationCommentField;
  String? paralysisCommentField;
  String? trainFourCommentField;
  String? bisCommentField;
  String? evdCommentField;
  String? spinalCommentField;
  String? tpaCommentField;
  String? ventCommentField;
  String? trachCommentField;
  String? chestCommentField;
  String? papCommentField;
  String? vitalsCommentField;
  String? painCommentField;
  String? consultCommentField;
  String? hxCommentField;
  String? gestationCommentField;
  String? bloodTypeCommentField;
  String? rhogamCommentField;
  String? gbsCommentField;
  String? steroidCommentField;
  String? monitorCommentField;
  String? deliveryDrop;
  String? anesthesiaDrop;
  String? fundalLocationDrop;
  String? perineumCommentField;
  String? incisionCommentField;
  String? feedingCommentField;
  String? rubellaStatusRadio;
  String? supportSystemCommentField;
  String? obhxCommentField;
  String? prxCommentField;
  String? ldxCommentField;
  String? disabilityCommentField;
  String? srxCommentField;
  String? imgCommentField;
  String? respiCommentField;
  String? cardioCommentField;
  String? mapCommentField;
  String? infCommentField;
  String? pacerCommentField;
  String? gastroCommentField;
  String? enteralCommentField;
  String? crrtCommentField;
  String? dialysisCommentField;
  String? genitoCommentField;
  String? reproCommentField;
  String? musculoCommentField;
  String? integuCommentField;
  String? stickyNoteBackgroundField;
  String? medHistoryField;
  String? currentMedsField;
  String? stickyNoteRecommendationField;
  String? stickyNoteSituationField;
  String? stickySigEventField;
  String? alertsDrop;

  String? neuroDrop;
  String? neuroDropId;
  String? respiDrop;
  String? respiDropId;
  String? cardioDrop;
  String? cardioDropId;
  String? gastroDrop;
  String? gastroDropId;
  String? genitoDrop;
  String? genitoDropId;
  String? musculoDrop;
  String? musculoDropId;
  String? integuDrop;
  String? integuDropId;
  String? isoDrop;
  String? isoDropId;
  String? disabilityDrop;
  String? disabilityDropId;
  String? lineDrop;
  String? lineDropId;
  String? consultDrop;
  String? consultDropId;
  String? medicalDx;
  String? medicalDxId;
  String? vitalSigns;
  String? vitalSignsId;
  String? painDrop;
  String? painDropId;
  String? medicalPrx;
  String? medicalPrxId;
  String? imagingPrx;
  String? imagingPrxId;
  String? surgicalPrx;
  String? surgicalPrxId;
  String? historicalDx;
  String? historicalDxId;
  String? labCommentField;
  String? wbcLabCommentField;
  String? hgbLabCommentField;
  String? hctLabCommentField;
  String? pltLabCommentField;
  String? naLabCommentField;
  String? kLabCommentField;
  String? clLabCommentField;
  String? co2LabCommentField;
  String? bunLabCommentField;
  String? creatLabCommentField;
  String? gluLabCommentField;
  String? calcLabCommentField;
  String? mgLabCommentField;
  String? po4LabCommentField;
  String? astLabCommentField;
  String? altLabCommentField;
  String? alpLabCommentField;
  String? biliLabCommentField;
  String? ptLabCommentField;
  String? pttLabCommentField;
  String? inrLabCommentField;

  Patient({
    this.id,
    //this.yesAdvancedAssessment,
    this.ptSpecialty,
    this.alertsDropId,
    this.allergiesRadio,
    this.alertsDrop,
    this.attendingMDField,
    this.consultMDField,
    this.specialistsField,
    this.obgynField,
    this.codeStatusDrop,
    this.culturalDrop,
    this.dietDrop,
    this.fontanelDrop,
    this.fundalDrop,
    this.lochiaDrop,
    this.ambuDrop,
    this.teleDrop,
    this.genderDrop,
    this.pronounDrop,
    this.nicknameField,
    this.ageField,
    this.babyAgeField,
    this.babyWeightCommentField,
    this.babyNicknameField,
    this.securityBandField,
    this.babySexRadio,
    this.patientAllergiesField,
    this.roomNumberField,
    this.genderRadio,
    this.labValuesField,
    this.weightField,
    this.heightField,
    this.measureCommentField,
    this.culturalCommentField,
    this.visitationCommentField,
    this.dxCommentField,
    this.dxInfCommentField,
    this.sdxCommentField,
    this.legalCommentField,
    this.alertsCommentField,
    this.neuroCommentField,
    this.camICUCommentField,
    this.rassCommentField,
    this.pupilsCommentField,
    this.sedationCommentField,
    this.paralysisCommentField,
    this.trainFourCommentField,
    this.bisCommentField,
    this.evdCommentField,
    this.spinalCommentField,
    this.tpaCommentField,
    this.ventCommentField,
    this.trachCommentField,
    this.chestCommentField,
    this.papCommentField,
    this.vitalsCommentField,
    this.painCommentField,
    this.consultCommentField,
    this.hxCommentField,
    this.gestationCommentField,
    this.bloodTypeCommentField,
    this.rhogamCommentField,
    this.gbsCommentField,
    this.steroidCommentField,
    this.monitorCommentField,
    this.deliveryDrop,
    this.anesthesiaDrop,
    this.fundalLocationDrop,
    this.perineumCommentField,
    this.incisionCommentField,
    this.feedingCommentField,
    this.rubellaStatusRadio,
    this.supportSystemCommentField,
    this.obhxCommentField,
    this.prxCommentField,
    this.ldxCommentField,
    this.disabilityCommentField,
    this.srxCommentField,
    this.imgCommentField,
    this.respiCommentField,
    this.cardioCommentField,
    this.mapCommentField,
    this.infCommentField,
    this.pacerCommentField,
    this.gastroCommentField,
    this.enteralCommentField,
    this.crrtCommentField,
    this.dialysisCommentField,
    this.genitoCommentField,
    this.reproCommentField,
    this.musculoCommentField,
    this.integuCommentField,
    this.stickyNoteSituationField,
    this.stickyNoteBackgroundField,
    this.medHistoryField,
    this.currentMedsField,
    this.stickyNoteAssessmentField,
    this.stickyNoteRecommendationField,
    this.stickySigEventField,
    this.medicalDx,
    this.medicalDxId,
    this.neuroDrop,
    this.neuroDropId,
    this.respiDrop,
    this.respiDropId,
    this.cardioDrop,
    this.cardioDropId,
    this.gastroDrop,
    this.gastroDropId,
    this.genitoDrop,
    this.genitoDropId,
    this.musculoDrop,
    this.musculoDropId,
    this.integuDrop,
    this.integuDropId,
    this.isoDrop,
    this.isoDropId,
    this.disabilityDrop,
    this.disabilityDropId,
    this.lineDrop,
    this.lineDropId,
    this.consultDrop,
    this.consultDropId,
    this.vitalSigns,
    this.vitalSignsId,
    this.painDrop,
    this.painDropId,
    this.medicalPrx,
    this.medicalPrxId,
    this.surgicalPrx,
    this.surgicalPrxId,
    this.imagingPrx,
    this.imagingPrxId,
    this.historicalDx,
    this.historicalDxId,
    this.labCommentField,
    this.wbcLabCommentField,
    this.hgbLabCommentField,
    this.hctLabCommentField,
    this.pltLabCommentField,
    this.naLabCommentField,
    this.kLabCommentField,
    this.clLabCommentField,
    this.co2LabCommentField,
    this.bunLabCommentField,
    this.creatLabCommentField,
    this.gluLabCommentField,
    this.calcLabCommentField,
    this.mgLabCommentField,
    this.po4LabCommentField,
    this.astLabCommentField,
    this.altLabCommentField,
    this.alpLabCommentField,
    this.biliLabCommentField,
    this.ptLabCommentField,
    this.pttLabCommentField,
    this.inrLabCommentField,
  });

  Patient.fromMap(Map<String?, dynamic> map) {
    id = map['id'] ?? '';
    //yesAdvancedAssessment = map['advanced_switch'] ?? '';
    ptSpecialty = map['ptSpecialty'] ?? '';
    alertsDropId = map['alerts_drop_id'] ?? '';
    allergiesRadio = map['allergies_radio'] ?? '';
    alertsDrop = map['alerts_drop'] ?? '';
    attendingMDField = map['attending_md_field'] ?? '';
    consultMDField = map['consult_md_field'] ?? '';
    specialistsField = map['specialists_field'] ?? '';
    obgynField = map['obgyn_field'] ?? '';
    codeStatusDrop = map['code_status_drop'] ?? '';
    culturalDrop = map['cultural_drop'] ?? '';
    dietDrop = map['diet_drop'] ?? '';
    fontanelDrop = map['fontanel_drop'] ?? '';
    fundalDrop = map['fundal_drop'] ?? '';
    lochiaDrop = map['lochia_drop'] ?? '';
    ambuDrop = map['ambu_drop'] ?? '';
    teleDrop = map['tele_drop'] ?? '';
    genderDrop = map['gender_drop'] ?? '';
    pronounDrop = map['pronoun_drop'] ?? '';
    nicknameField = map['nickname_field'] ?? '';
    ageField = map['age_field'] ?? '';
    babyAgeField = map['baby_age_field'] ?? '';
    babyWeightCommentField = map['baby_weight_comment_field'] ?? '';
    babyNicknameField = map['baby_nickname_field'] ?? '';
    securityBandField = map['security_band_field'] ?? '';
    babySexRadio = map['baby_sex_radio'] ?? '';
    patientAllergiesField = map['patient_allergies_field'] ?? '';
    roomNumberField = map['room_number_field'] ?? '';
    genderRadio = map['gender_radio'] ?? '';
    labValuesField = map['lab_values_field'] ?? '';
    labCommentField = map['lab_comment_field'] ?? '';
    heightField = map['height_field'] ?? '';
    weightField = map['weight_field'] ?? '';
    measureCommentField = map['measure_comment_field'] ?? '';
    culturalCommentField = map['cultural_comment_field'] ?? '';
    visitationCommentField = map['visitation_comment_field'] ?? '';
    dxCommentField = map['dx_comment_field'] ?? '';
    dxInfCommentField = map['dx_inf_comment_field'] ?? '';
    sdxCommentField = map['sdx_comment_field'] ?? '';
    legalCommentField = map['legal_comment_field'] ?? '';
    alertsCommentField = map['alerts_comment_field'] ?? '';
    neuroCommentField = map['neuro_comment_field'] ?? '';
    camICUCommentField = map['camicu_comment_field'] ?? '';
    rassCommentField = map['rass_comment_field'] ?? '';
    pupilsCommentField = map['pupils_comment_field'] ?? '';
    sedationCommentField = map['sedation_comment_field'] ?? '';
    paralysisCommentField = map['paralysis_comment_field'] ?? '';
    trainFourCommentField = map['trainfour_comment_field'] ?? '';
    bisCommentField = map['bis_comment_field'] ?? '';
    evdCommentField = map['evd_comment_field'] ?? '';
    spinalCommentField = map['spinal_comment_field'] ?? '';
    tpaCommentField = map['tpa_comment_field'] ?? '';
    ventCommentField = map['vent_comment_field'] ?? '';
    trachCommentField = map['trach_comment_field'] ?? '';
    chestCommentField = map['chest_comment_field'] ?? '';
    papCommentField = map['pap_comment_field'] ?? '';
    vitalsCommentField = map['vitals_comment_field'] ?? '';
    painCommentField = map['pain_comment_field'] ?? '';
    consultCommentField = map['consult_comment_field'] ?? '';
    hxCommentField = map['hx_comment_field'] ?? '';
    gestationCommentField = map['gestation_comment_field'] ?? '';
    bloodTypeCommentField = map['bloodType_comment_field'] ?? '';
    rhogamCommentField = map['rhogam_comment_field'] ?? '';
    gbsCommentField = map['gbs_comment_field'] ?? '';
    steroidCommentField = map['steroid_comment_field'] ?? '';
    monitorCommentField = map['monitor_comment_field'] ?? '';
    deliveryDrop = map['delivery_drop'] ?? '';
    anesthesiaDrop = map['anesthesia_drop'] ?? '';
    fundalLocationDrop = map['fundal_location_drop'] ?? '';
    perineumCommentField = map['perineum_comment_field'] ?? '';
    incisionCommentField = map['incision_comment_field'] ?? '';
    feedingCommentField = map['feeding_comment_field'] ?? '';
    rubellaStatusRadio = map['rubella_status_radio'] ?? '';
    supportSystemCommentField = map['support_system_comment_field'] ?? '';
    obhxCommentField = map['obhx_comment_field'] ?? '';
    prxCommentField = map['prx_comment_field'] ?? '';
    ldxCommentField = map['ldx_comment_field'] ?? '';
    disabilityCommentField = map['disability_comment_field'] ?? '';
    srxCommentField = map['srx_comment_field'] ?? '';
    imgCommentField = map['img_comment_field'] ?? '';
    respiCommentField = map['respi_comment_field'] ?? '';
    mapCommentField = map['map_comment_field'] ?? '';
    cardioCommentField = map['cardio_comment_field'] ?? '';
    infCommentField = map['inf_comment_field'] ?? '';
    pacerCommentField = map['pacer_comment_field'] ?? '';
    gastroCommentField = map['gastro_comment_field'] ?? '';
    enteralCommentField = map['enteral_comment_field'] ?? '';
    crrtCommentField = map['crrt_comment_field'] ?? '';
    dialysisCommentField = map['dialysis_comment_field'] ?? '';
    genitoCommentField = map['genito_comment_field'] ?? '';
    reproCommentField = map['repro_comment_field'] ?? '';
    musculoCommentField = map['musculo_comment_field'] ?? '';
    integuCommentField = map['integu_comment_field'] ?? '';
    stickyNoteSituationField = map['sticky_notes_situation_field'] ?? '';
    stickyNoteBackgroundField = map['sticky_note_background_field'] ?? '';
    medHistoryField = map['med_history_field'] ?? '';
    currentMedsField = map['current_meds_field'] ?? '';
    stickyNoteAssessmentField = map['sticky_note_assessment_field'] ?? '';
    stickyNoteRecommendationField =
        map['sticky_note_recommendation_field'] ?? '';
    stickySigEventField = map['sticky_sig_event_field'] ?? '';
    medicalDx = map['medical_dx'] ?? '';
    medicalDxId = map['medical_dx_id'] ?? '';
    neuroDrop = map['neuro_drop'] ?? '';
    neuroDropId = map['neuro_drop_id'] ?? '';
    respiDrop = map['respi_drop'] ?? '';
    respiDropId = map['respi_drop_id'] ?? '';
    cardioDrop = map['cardio_drop'] ?? '';
    cardioDropId = map['cardio_drop_id'] ?? '';
    gastroDrop = map['gastro_drop'] ?? '';
    gastroDropId = map['gastro_drop_id'] ?? '';
    genitoDrop = map['genito_drop'] ?? '';
    genitoDropId = map['genito_drop_id'] ?? '';
    musculoDrop = map['musculo_drop'] ?? '';
    musculoDropId = map['musculo_drop_id'] ?? '';
    integuDrop = map['integu_drop'] ?? '';
    integuDropId = map['integu_drop_id'] ?? '';
    isoDrop = map['iso_drop'] ?? '';
    isoDropId = map['iso_drop_id'] ?? '';
    disabilityDrop = map['disability_drop'] ?? '';
    disabilityDropId = map['disability_drop_id'] ?? '';
    lineDrop = map['line_drop'] ?? '';
    lineDropId = map['line_drop_id'] ?? '';
    consultDrop = map['consult_drop'] ?? '';
    consultDropId = map['consult_drop_id'] ?? '';
    vitalSigns = map['vital_signs'] ?? '';
    vitalSignsId = map['vital_signs_id'] ?? '';
    painDrop = map['pain_drop'] ?? '';
    painDropId = map['pain_drop_id'] ?? '';
    medicalPrx = map['medical_prx'] ?? '';
    medicalPrxId = map['medical_prx_id'] ?? '';
    surgicalPrx = map['surgical_prx'] ?? '';
    surgicalPrxId = map['surgical_prx_id'] ?? '';
    imagingPrx = map['imaging_prx'] ?? '';
    imagingPrxId = map['imaging_prx_id'] ?? '';
    historicalDx = map['historical_dx'] ?? '';
    historicalDxId = map['historical_dx_id'] ?? '';
    wbcLabCommentField = map['wbc_lab_comment_field'] ?? '';
    hgbLabCommentField = map['hgb_lab_comment_field'] ?? '';
    hctLabCommentField = map['hct_lab_comment_field'] ?? '';
    pltLabCommentField = map['plt_lab_comment_field'] ?? '';
    naLabCommentField = map['na_lab_comment_field'] ?? '';
    kLabCommentField = map['k_lab_comment_field'] ?? '';
    clLabCommentField = map['cl_lab_comment_field'] ?? '';
    co2LabCommentField = map['co2_lab_comment_field'] ?? '';
    bunLabCommentField = map['bun_lab_comment_field'] ?? '';
    creatLabCommentField = map['creat_lab_comment_field'] ?? '';
    gluLabCommentField = map['glu_lab_comment_field'] ?? '';
    calcLabCommentField = map['calc_lab_comment_field'] ?? '';
    mgLabCommentField = map['mg_lab_comment_field'] ?? '';
    po4LabCommentField = map['po4_lab_comment_field'] ?? '';
    astLabCommentField = map['ast_lab_comment_field'] ?? '';
    altLabCommentField = map['alt_lab_comment_field'] ?? '';
    alpLabCommentField = map['alp_lab_comment_field'] ?? '';
    biliLabCommentField = map['bili_lab_comment_field'] ?? '';
    ptLabCommentField = map['pt_lab_comment_field'] ?? '';
    pttLabCommentField = map['ptt_lab_comment_field'] ?? '';
    inrLabCommentField = map['inr_lab_comment_field'] ?? '';
  }

  Map<String?, dynamic> toMap() => {
        'id': id,
        //'advanced_switch': yesAdvancedAssessment,
        'ptSpecialty': ptSpecialty,
        'alerts_drop_id': alertsDropId,
        'allergies_radio': allergiesRadio,
        'alerts_drop': alertsDrop,
        'attending_md_field': attendingMDField,
        'consult_md_field': consultMDField,
        'specialists_field': specialistsField,
        'obgyn_field': obgynField,
        'code_status_drop': codeStatusDrop,
        'cultural_drop': culturalDrop,
        'diet_drop': dietDrop,
        'fontanel_drop': fontanelDrop,
        'fundal_drop': fundalDrop,
        'lochia_drop': lochiaDrop,
        'ambu_drop': ambuDrop,
        'tele_drop': teleDrop,
        'gender_drop': genderDrop,
        'pronoun_drop': pronounDrop,
        'nickname_field': nicknameField,
        'age_field': ageField,
        'baby_age_field': babyAgeField,
        'baby_weight_comment_field': babyWeightCommentField,
        'baby_nickname_field': babyNicknameField,
        'security_band_field': securityBandField,
        'baby_sex_radio': babySexRadio,
        'patient_allergies_field': patientAllergiesField,
        'room_number_field': roomNumberField,
        'gender_radio': genderRadio,
        'lab_values_field': labValuesField,
        'lab_comment_field': labCommentField,
        'weight_field': weightField,
        'height_field': heightField,
        'measure_comment_field': measureCommentField,
        'cultural_comment_field': culturalCommentField,
        'visitation_comment_field': visitationCommentField,
        'dx_comment_field': dxCommentField,
        'dx_inf_comment_field': dxInfCommentField,
        'sdx_comment_field': sdxCommentField,
        'legal_comment_field': legalCommentField,
        'alerts_comment_field': alertsCommentField,
        'neuro_comment_field': neuroCommentField,
        'camicu_comment_field': camICUCommentField,
        'rass_comment_field': rassCommentField,
        'pupils_comment_field': pupilsCommentField,
        'sedation_comment_field': sedationCommentField,
        'paralysis_comment_field': paralysisCommentField,
        'trainfour_comment_field': trainFourCommentField,
        'bis_comment_field': bisCommentField,
        'evd_comment_field': evdCommentField,
        'spinal_comment_field': spinalCommentField,
        'tpa_comment_field': tpaCommentField,
        'vent_comment_field': ventCommentField,
        'trach_comment_field': trachCommentField,
        'chest_comment_field': chestCommentField,
        'pap_comment_field': papCommentField,
        'vitals_comment_field': vitalsCommentField,
        'pain_comment_field': painCommentField,
        'consult_comment_field': consultCommentField,
        'hx_comment_field': hxCommentField,
        'gestation_comment_field': gestationCommentField,
        'steroid_comment_field': steroidCommentField,
        'bloodType_comment_field': bloodTypeCommentField,
        'rhogam_comment_field': rhogamCommentField,
        'gbs_comment_field': gbsCommentField,
        'monitor_comment_field': monitorCommentField,
        'delivery_drop': deliveryDrop,
        'anesthesia_drop': anesthesiaDrop,
        'fundal_location_drop': fundalLocationDrop,
        'perineum_comment_field': perineumCommentField,
        'incision_comment_field': incisionCommentField,
        'feeding_comment_field': feedingCommentField,
        'rubella_status_radio': rubellaStatusRadio,
        'support_system_comment_field': supportSystemCommentField,
        'obhx_comment_field': obhxCommentField,
        'prx_comment_field': prxCommentField,
        'ldx_comment_field': ldxCommentField,
        'disability_comment_field': disabilityCommentField,
        'srx_comment_field': srxCommentField,
        'img_comment_field': imgCommentField,
        'respi_comment_field': respiCommentField,
        'cardio_comment_field': cardioCommentField,
        'map_comment_field': mapCommentField,
        'inf_comment_field': infCommentField,
        'pacer_comment_field': pacerCommentField,
        'gastro_comment_field': gastroCommentField,
        'enteral_comment_field': enteralCommentField,
        'crrt_comment_field': crrtCommentField,
        'dialysis_comment_field': dialysisCommentField,
        'genito_comment_field': genitoCommentField,
        'repro_comment_field': reproCommentField,
        'musculo_comment_field': musculoCommentField,
        'integu_comment_field': integuCommentField,
        'sticky_notes_situation_field': stickyNoteSituationField,
        'sticky_note_background_field': stickyNoteBackgroundField,
        'med_history_field': medHistoryField,
        'current_meds_field': currentMedsField,
        'sticky_note_assessment_field': stickyNoteAssessmentField,
        'sticky_note_recommendation_field': stickyNoteRecommendationField,
        'sticky_sig_event_field': stickySigEventField,
        'medical_dx': medicalDx,
        'medical_dx_id': medicalDxId,
        'neuro_drop': neuroDrop,
        'neuro_drop_id': neuroDropId,
        'respi_drop': respiDrop,
        'respi_drop_id': respiDropId,
        'cardio_drop': cardioDrop,
        'cardio_drop_id': cardioDropId,
        'gastro_drop': gastroDrop,
        'gastro_drop_id': gastroDropId,
        'genito_drop': genitoDrop,
        'genito_drop_id': genitoDropId,
        'musculo_drop': musculoDrop,
        'musculo_drop_id': musculoDropId,
        'integu_drop': integuDrop,
        'integu_drop_id': integuDropId,
        'iso_drop': isoDrop,
        'iso_drop_id': isoDropId,
        'disability_drop': disabilityDrop,
        'disability_drop_id': disabilityDropId,
        'line_drop': lineDrop,
        'line_drop_id': lineDropId,
        'consult_drop': consultDrop,
        'consult_drop_id': consultDropId,
        'vital_signs': vitalSigns,
        'vital_signs_id': vitalSignsId,
        'pain_drop': painDrop,
        'pain_drop_id': painDropId,
        'medical_prx': medicalPrx,
        'medical_prx_id': medicalPrxId,
        'surgical_prx': surgicalPrx,
        'surgical_prx_id': surgicalPrxId,
        'imaging_prx': imagingPrx,
        'imaging_prx_id': imagingPrxId,
        'historical_dx': historicalDx,
        'historical_dx_id': historicalDxId,
        'wbc_lab_comment_field': wbcLabCommentField,
        'hgb_lab_comment_field': hgbLabCommentField,
        'hct_lab_comment_field': hctLabCommentField,
        'plt_lab_comment_field': pltLabCommentField,
        'na_lab_comment_field': naLabCommentField,
        'k_lab_comment_field': kLabCommentField,
        'cl_lab_comment_field': clLabCommentField,
        'co2_lab_comment_field': co2LabCommentField,
        'bun_lab_comment_field': bunLabCommentField,
        'creat_lab_comment_field': creatLabCommentField,
        'glu_lab_comment_field': gluLabCommentField,
        'calc_lab_comment_field': calcLabCommentField,
        'mg_lab_comment_field': mgLabCommentField,
        'po4_lab_comment_field': po4LabCommentField,
        'ast_lab_comment_field': astLabCommentField,
        'alt_lab_comment_field': altLabCommentField,
        'alp_lab_comment_field': alpLabCommentField,
        'bili_lab_comment_field': biliLabCommentField,
        'pt_lab_comment_field': ptLabCommentField,
        'ptt_lab_comment_field': pttLabCommentField,
        'inr_lab_comment_field': inrLabCommentField,
      };
}
