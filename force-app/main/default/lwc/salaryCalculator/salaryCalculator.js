import { LightningElement, track} from 'lwc';
export default class SalaryCalculator extends LightningElement {

    social_Security = 6.2;
    medicare1 = 1.45;
    //const medicare2 = 2.35;
    value = '';
    tax_settlement = '';
    taxable_income = '';
    taxes_owed = '';
    @ track grossSalary = '';
    nettoSalary = '';
    standard_deduction = '';
    rate = '';

    get options() {
        return [
            // { label: '--None--', name :'None',value: 'None' },
            { label: 'Single', name :'Single',value: 'Single' },
            { label: 'Head of hausehold', name :'Head of hausehold', value: 'Head_of_hausehold' },
            { label: 'Married filing jontly', name :'Married filing jontly', value: 'Married_Filing_Jontly' },
            { label: 'Married Filing Separetly', name :'Married Filing Separetly', value: 'Married_Filing_Separetly' },
        ];
    }

    handleChange(event) {
        //this.tax_settlement = event.detail.value;
        this.tax_settlement = event.target.value;

        console.log('category of tax:' + this.tax_settlement);
    
        if (this.tax_settlement === 'Single') {
            this.standard_deduction = 14600;
            console.log('Standard deduction for Single: ' + this.standard_deduction);
            console.log('your rate is ' + this.rate);
        } else if (this.tax_settlement === 'Head_of_hausehold') {
            this.standard_deduction = 21900; 
            console.log('Standard deduction for Head of Household: ' + this.standard_deduction);
        } else if (this.tax_settlement === 'Married_Filing_Jontly') {
            this.standard_deduction = 29200; 
            console.log('Standard deduction for Married Filing Jointly: ' + this.standard_deduction);
        } else if (this.tax_settlement === 'Married_Filing_Separetly') {
            this.standard_deduction = 14600; 
            console.log('Standard deduction for Married Filing Separately: ' + this.standard_deduction);
        }
    }
    
    handleChangeSalary(event){
        //let value = Number(event.target.value);
        //this.grossSalary = event.detail.value;
        this.grossSalary = Number(event.target.value);
        console.log('this.grossSalary '+ this.grossSalary);
    }
    
    handleClick(){
        if (this.grossSalary === '' || this.grossSalary === null) {
            alert('Please enter your gross salary');
            return;
        }
    
        if (this.grossSalary !== '' && this.tax_settlement === 'Single') {
            this.calculateRateWhenSingle(this.grossSalary);
            console.log('this.grossSalary =' + this.grossSalary);
            console.log('your rate is ' + this.rate);
            console.log('category of tax should by Single'+ this.tax_settlement);
            console.log('this.grossSalary =' + this.grossSalary);
            console.log('standard_deduction =' + this.standard_deduction);
        } else if (this.grossSalary !== '' && this.tax_settlement === 'Head_of_hausehold') {
            this.calculateRateWhenHead(this.grossSalary);
        } else if (this.grossSalary !== '' && this.tax_settlement === 'Married_Filing_Jontly') {
            this.calculateRateWhenMarried_Jontly(this.grossSalary);
        } else if (this.grossSalary !== '' && this.tax_settlement === 'Married_Filing_Separetly') {
            this.calculateRateWhenMarried_Separetly(this.grossSalary);
        }
        
        if (this.grossSalary !== '') {
            this.taxable_income = (this.grossSalary - this.standard_deduction);
            this.taxes_owed = (this.taxable_income * this.rate);
            this.calculateSocialSecurity(this.grossSalary);
            this.calculateMedicare1(this.grossSalary);
            this.nettoSalary = this.grossSalary - this.taxes_owed;
    
            console.log('taxes_owed =' + this.taxes_owed);
            console.log('netto salary without social_Security & medicare1=' + this.nettoSalary);

            this.finalNettoSalary = this.nettoSalary - this.socialSecurityValue - this.medicareValue;
            console.log('final netto salary =' + this.finalNettoSalary);
        }
    }

    calculateRateWhenSingle(grossSalary){
        if(this.grossSalary <= 0 && this.grossSalary < 11925){
            this.rate = 0.1 ;
        }else if(this.grossSalary >= 11925 && this.grossSalary < 48475){
            this.rate = 0.12;
        }else if(this.grossSalary >= 48475 && this.grossSalary < 103350){
            this.rate = 0.22;
        }else if(this.grossSalary >= 103350 && this.grossSalary < 197300){
            this.rate = 0.24;
        }else if(this.grossSalary >= 197300 && this.grossSalary < 250525){
            this.rate = 0.32;
        }else if(this.grossSalary >= 250525 && this.grossSalary < 626350){
            this.rate = 0.35;
        }else if(this.grossSalary >= 626350){
            this.rate = 0.37;
        }
    }

    calculateRateWhenHead(grossSalary){
        if(this.grossSalary <= 0 && this.grossSalary < 16550){
            this.rate = 0.1 ;
        }else if(this.grossSalary >= 16550 && this.grossSalary < 63100){
            this.rate = 0.12;
        }else if(this.grossSalary >= 63100 && this.grossSalary < 100500){
            this.rate = 0.22;
        }else if(this.grossSalary >= 100500 && this.grossSalary < 191950){
            this.rate = 0.24;
        }else if(this.grossSalary >= 191950 && this.grossSalary < 243700){
            this.rate = 0.32;
        }else if(this.grossSalary >= 243700 && this.grossSalary < 609350){
            this.rate = 0.35;
        }else if(this.grossSalary >= 609350){
            this.rate = 0.37;}
    }

    calculateRateWhenMarried_Jontly(grossSalary){
        if(this.grossSalary <= 0 && this.grossSalary < 23.200){
            this.rate = 0.1 ;
        }else if(this.grossSalary >= 23200 && this.grossSalary < 94300){
            this.rate = 0.12;
        }else if(this.grossSalary >= 94300 && this.grossSalary < 201050){
            this.rate = 0.22;
        }else if(this.grossSalary >= 201050 && this.grossSalary < 383900){
            this.rate = 0.24;
        }else if(this.grossSalary >= 383900 && this.grossSalary < 487450){
            this.rate = 0.32;
        }else if(this.grossSalary >= 487450 && this.grossSalary < 731200){
            this.rate = 0.35;
        }else if(this.grossSalary >= 731200){
            this.rate = 0.37;}
    }

    calculateRateWhenMarried_Separetly(grossSalary){
        if(this.grossSalary <= 0 && this.grossSalary < 11.600){
            this.rate = 0.1 ;
        }else if(this.grossSalary >= 11600 && this.grossSalary < 47150){
            this.rate = 0.12;
        }else if(this.grossSalary >= 47150 && this.grossSalary < 100525){
            this.rate = 0.22;
        }else if(this.grossSalary >= 100525 && this.grossSalary < 191950){
            this.rate = 0.24;
        }else if(this.grossSalary >= 191950 && this.grossSalary < 243725){
            this.rate = 0.32;
        }else if(this.grossSalary >= 243725 && this.grossSalary < 365600){
            this.rate = 0.35;
        }else if(this.grossSalary >= 365600){
            this.rate = 0.37;}
    }

    calculateSocialSecurity(grossSalary){
        let taxableSalary = grossSalary; // Używamy argumentu przekazanego do funkcji
        if(taxableSalary > this.wageBaseLimit){
            taxableSalary = 176100;
        }
        this.socialSecurityValue = taxableSalary * this.social_Security / 100;
    }
    
    calculateMedicare1(grossSalary){ 
            this.medicareValue = this.grossSalary * this.medicare1 /100;
    }

}