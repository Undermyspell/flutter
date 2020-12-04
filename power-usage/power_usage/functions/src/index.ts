import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

const db = admin.firestore();

export const createYearlySumOnUsageCreation = functions.firestore
    .document("usages/{docId}")
    .onWrite((change, context) => { 
    const year: string = change.after.get("year");
    return db.collection("usages").where("year", "==", year)
        .get()
        .then(usages => {

        const sums = {
            sumCounterMeterConsumption:0,
            sumCounterMeterFeedIn: 0,
            sumConsumptionHeating: 0,
            sumConsumptionWarmWater: 0,
            sumConsumptionSonnenApp: 0,
            sumConsumptionGridSonnenApp:0
        }

        usages.docs.reduce((prev, curr) => {
            prev.sumCounterMeterConsumption += curr.get("counterMeterConsumption");
            prev.sumCounterMeterFeedIn += curr.get("counterMeterFeedIn");
            prev.sumConsumptionHeating += curr.get("consumptionHeating");
            prev.sumConsumptionWarmWater += curr.get("consumptionWarmWater");
            prev.sumConsumptionSonnenApp += curr.get("consumptionSonnenApp");
            prev.sumConsumptionGridSonnenApp += curr.get("consumptionGridSonnenApp");
            return prev;
        }, sums);
        console.log(year);
        
        return db.collection("yearlysums").doc(year.toString()).set({
            year: year,
            ...sums
        });
    });
});
