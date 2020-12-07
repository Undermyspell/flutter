import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

const db = admin.firestore();

export const createYearlySumOnUsageCreation = functions.firestore
    .document("usages/{docId}")
    .onWrite((change, context) => {
        const year: string = change.after.get("year");
        return db.collection("usages")
            .where("year", "==", year)
            .get()
            .then(usages => {

                const sums = {
                    sumCounterMeterConsumption: 0,
                    sumCounterMeterFeedIn: 0,
                    sumConsumptionHeating: 0,
                    sumConsumptionWarmWater: 0,
                    sumConsumptionSonnenApp: 0,
                    sumConsumptionGridSonnenApp: 0
                }

                usages.docs.reduce((prev, curr) => {
                    let prevMonthUsage = usages.docs
                        .filter(u => +u.get("month") < +curr.get("month"))
                        .sort((u1, u2) => +u2.get("month") - +u1.get("month"))
                        .find(_ => true);

                    prev.sumCounterMeterConsumption += !!prevMonthUsage ? curr.get("counterMeterConsumption") - prevMonthUsage.get("counterMeterConsumption") : 0;
                    prev.sumCounterMeterFeedIn += !!prevMonthUsage ? curr.get("counterMeterFeedIn") - prevMonthUsage.get("counterMeterFeedIn") : 0;
                    prev.sumConsumptionHeating += curr.get("consumptionHeating");
                    prev.sumConsumptionWarmWater += curr.get("consumptionWarmWater");
                    prev.sumConsumptionSonnenApp += curr.get("consumptionSonnenApp");
                    prev.sumConsumptionGridSonnenApp += curr.get("consumptionGridSonnenApp");
                    return prev;
                }, sums);

                return db.collection("yearlysums").doc(year.toString()).set({
                    year: year,
                    ...sums
                });
            });
    });
