//
//  ViewController.swift
//  Calculator_final
//
//  Created by CIS on 4/22/18.
//  Copyright © 2018 CIS. All rights reserved.
//

import UIKit
extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let idx1 = index(startIndex, offsetBy: range.lowerBound)
        let idx2 = index(startIndex, offsetBy: range.upperBound)
        return String(self[idx1..<idx2])
    }
    var count: Int { return characters.count }
}

extension String {
    func condenseWhitespace() -> String {
        let components = self.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
}

extension String  {
    var isNumber: Bool {
        get {
            return Double(self) != nil
        }
    }
}
class ViewController: UIViewController {
    struct Stack<String> {
        fileprivate var array: [String] = []
        
        mutating func push(_ element: String) {
            array.append(element)
        }
        
        mutating func pop() -> String? {
            return array.popLast()
        }
        
        func peek() -> String? {
            return array.last
        }

    }
    var string="";
    var flag=true;
    var dem=0;
    var dec = true;
    @IBOutlet weak var lblRad: UIButton!
    @IBOutlet weak var lblDec: UIButton!
    @IBOutlet weak var lblDisplay: UILabel!
    @IBOutlet weak var lblHeader: UILabel!
    @IBAction func changeOption(_ sender: UIButton)
    {
        let name = sender.titleLabel?.text
        if(name == "Degrees")
        {
            sender.titleLabel?.textColor = UIColor.red;
            lblRad.titleLabel?.textColor = UIColor.black;
            lblDec.isEnabled=true
            dec = true
        }
        else{
            lblRad.setTitleColor(UIColor.red, for: UIControlState.normal)
            lblDec.titleLabel?.textColor = UIColor.black;

            lblRad.isEnabled=true
            dec = false
        }
        
    }
    @IBAction func onClickPi(_ sender: UIButton) {
        if(!string.contains("=")){
        if (string==""||string.characters.count<65){
            if (string.characters.count>=1){
                if (string.characters.last!==")"||string.characters.last!=="π" || string.characters.last!=="." || isNumber(string: String(describing: string.characters.last))){
                    return;}
            }
            if (string=="" && sender.titleLabel!.text!==""){
                return;}
            else {
                if (lblDisplay.text!==""){
                    string = sender.titleLabel!.text!
                    
                }
                else{
                    string = string + sender.titleLabel!.text!
                }
                
            }
            self.lblDisplay.text=string;
            
            
        }
        else{
            print("error")
        }
        }else{
            string="π"
            self.lblDisplay.text=string;
        }
        
    }

    @IBAction func onClickSinCosTanLn(_ sender: UIButton) {
        var j = -1;
        let arr = Array(string.characters)
        let length = string.characters.count
        let name = sender.titleLabel?.text!
        var pi = (Double.pi)/180
        if(!dec){
            pi = 1
        }
        if !string.contains("="){
        if(length>=1 && string != "-"){
            if(String(arr[length-1]).isNumber || arr[length-1]=="π"){
                for (i,element) in arr.enumerated().reversed(){
                    if isAOperation(string: String(element)) {
                        j = i;
                        break
                    }
                }
                let suffix = string.index(string.endIndex, offsetBy: -(length-j-1))
                var num = Double(string.substring(from: suffix))
                var value:String = "\(num ?? 0)"
                if arr[length-1]=="π" {
                    num = Double.pi
                    value = "π"
                }
                
                let stringTmp = string.substring(to: suffix)
                if name == "sin" {
                    let si = sin(num!*pi)
                    let roun = Double(round(10000*si)/10000)
                    string = stringTmp + String(describing: roun)
                    self.lblHeader.text = name! + "(" + value + ")=" + String(roun);
                    if String(roun).contains("."){
                        flag = false
                    }
                }else if name == "cos" {
                    let si = cos(num!*pi)
                    let roun = Double(round(10000*si)/10000)
                    string = stringTmp + String(roun)
                    self.lblHeader.text = name! + "(" + value + ")=" + String(roun);
                    if String(roun).contains("."){
                        flag = false
                    }
                }
                else if name == "tan" {
                    let si = tan(num!*pi)
                    let roun = Double(round(10000*si)/10000)
                    string = stringTmp + String(roun)
                    self.lblHeader.text = name! + "(" + value + ")=" + String(roun);
                    if String(roun).contains("."){
                        flag = false
                    }
                }
                else if name == "ln"{
                    let si = log(num!)
                    let roun = Double(round(10000*si)/10000)
                    string = stringTmp + String(roun)
                    self.lblHeader.text = name! + "(" + value + ")=" + String(roun);
                    if String(roun).contains("."){
                        flag = false
                    }
                }
            }
            
        }else if string == ""{
            let num = Double(0);
            if name == "sin" {
                let si = sin(num*pi)
                let roun = Double(round(10000*si)/10000)
                string = String(describing: roun)
                self.lblHeader.text = name! + "(0)=" + String(roun);
                if String(roun).contains("."){
                    flag = false
                }
            }else if name == "cos" {
                let si = cos(num*pi)
                let roun = Double(round(10000*si)/10000)
                string = String(roun)
                self.lblHeader.text = name! + "(0)=" + String(roun);
                if String(roun).contains("."){
                    flag = false
                }
            }
            else if name == "tan" {
                let si = tan(num*pi)
                let roun = Double(round(10000*si)/10000)
                string = String(roun)
                self.lblHeader.text = name! + "(0)=" + String(roun);
                if String(roun).contains("."){
                    flag = false
                }
            }
            else if name == "ln"{
                let si = log(num)
                let roun = Double(round(10000*si)/10000)
                string = String(roun)
                self.lblHeader.text = name! + "(0)=" + String(roun);
                if String(roun).contains("."){
                    flag = false
                }
            }
            
        }
        } else if !string.contains("R") && !string.contains("inf") && string.contains("=") && dem==0{
            for (i,element) in arr.enumerated().reversed(){
                if element=="=" {
                    j = i;
                    break;
                }
            }
            let a = String(string.characters.suffix(length-j-1))
            let num = Double(a)
            if name == "sin" {
                let si = sin(num!*pi)
                let roun = Double(round(10000*si)/10000)
                string = String(describing: roun)
                self.lblHeader.text = name! + "(" + a + ")" + "=" + String(roun);
                if String(roun).contains("."){
                    flag = false
                }
            }else if name == "cos" {
                let si = cos(num!*pi)
                let roun = Double(round(10000*si)/10000)
                string = String(roun)
                self.lblHeader.text = name! + "(" + a + ")" + "=" + String(roun);
                if String(roun).contains("."){
                    flag = false
                }
            }
            else if name == "tan" {
                let si = tan(num!*pi)
                let roun = Double(round(10000*si)/10000)
                string = String(roun)
                self.lblHeader.text = name! + "(" + a + ")" + "=" + String(roun);
                if String(roun).contains("."){
                    flag = false
                }
            }
            else if name == "ln"{
                let si = log(num!)
                let roun = Double(round(10000*si)/10000)
                string = String(roun)
                self.lblHeader.text = name! + "(" + a + ")" + "=" + String(roun);
                if String(roun).contains("."){
                    flag = false
                }
            }

            
        }
        if length>1 && arr[length-1] == ")"  {
            for (i,element) in arr.enumerated().reversed(){
                if element == "(" {
                    j = i;
                    break
                }
            }
            var suffix = string.index(string.endIndex, offsetBy: -(length-j))
            if dem == 0{
                var k = 0
                for (i,element) in arr.enumerated(){
                    if element == "(" {
                        k = i;
                        break
                    }
                }
                suffix = string.index(string.startIndex, offsetBy: k)
            
            }
            let num = string.substring(from: suffix)
            print(num)
            let stringTmp = string.substring(to: suffix)
            var stack = Stack<String>();
            var kcats = Stack<String>();
            let a = Infix2Postfix(infix: num);
            var line = a.components(separatedBy: " ")
            for i in 0..<line.count-1 {
                stack.push(line[i]);
            }
            while (!stack.array.isEmpty) {
                kcats.push(stack.pop()!);
            }
            let kq = Solve(s: kcats);
            stack.array.removeAll()
            kcats.array.removeAll()
            if name == "sin" {
                let si = sin(kq*pi)
                let roun = Double(round(10000*si)/10000)
                string =    stringTmp + String(describing: roun)
                self.lblHeader.text = name!+num+"="+String(describing: roun)
                if String(roun).contains("."){
                    flag = false
                }
            }else if name == "cos" {
                let si = cos(kq*pi)
                let roun = Double(round(10000*si)/10000)
                self.lblHeader.text = name!+num+"="+String(describing: roun)
                string = stringTmp + String(roun)
                if String(roun).contains("."){
                    flag = false
                }
            }
            else if name == "tan" {
                let si = tan(kq*pi)
                let roun = Double(round(10000*si)/10000)
                string = stringTmp + String(roun)
                self.lblHeader.text = name!+num+"="+String(describing: roun)
                if String(roun).contains("."){
                    flag = false
                }
            }
            else if name == "ln"{
                let si = log(kq)
                let roun = Double(round(10000*si)/10000)
                string = stringTmp + String(roun)
                self.lblHeader.text = name!+num+"="+String(describing: roun)
                if String(roun).contains("."){
                    flag = false
                }
            }
            
        }
        self.lblDisplay.text = string
    }
    @IBAction func onClickNumber(_ sender: UIButton) {
        if(!string.contains("=")){
        if (string==""||string.characters.count<52){
            if (string.characters.count>=1){
                if (string.characters.last!==")" || string.characters.last!=="π" ){
                    return;}
            }
            if (string=="" && sender.titleLabel!.text!==""){
                    return;}
            else {
                if (lblDisplay.text!==""){
                    string = sender.titleLabel!.text!

                }
                else{
                    string = string + sender.titleLabel!.text!
                }
                
            }
           self.lblDisplay.text=string;
        
            
        }
        else{
            print("error")
        }
        }else{
            string=sender.titleLabel!.text!
            self.lblDisplay.text=string;
        }
        //self.lblDisplay.text=lblDisplay.text!+sender.titleLabel!.text!;
    }

    @IBAction func onClickEditOperation(_ sender: UIButton) {
        
        var j = -1;
        let length = string.characters.count
        if (string == "" || length < 52){
        if(!string.contains("=")){
            if (length >= 1){
            if (isNumber(string: String(describing: string.characters.last))) {
                let s = Array(string.characters);
                for (index, element) in s.enumerated().reversed() {


                    if (isAOperation(string: String(element))) {
                        j = index;
                        break;
                    }
                }
                if (j == -1) {
                    if (!string.contains("-")) {
                        if (string.characters.first == "("){
                            string = String(string.characters.prefix(1)) + "−" + String(string.characters.suffix(length-1));}
                        else{
                            string = "−" + string;}
                    } else{
                        string = String(string.characters.suffix(length-1));}
                }
                else{
                let suffix = string.index(string.endIndex, offsetBy: -(length-j-1))
                let startToOperation = string.characters.prefix(j+1)
                let sign = startToOperation.last
                let sign2 = string.characters.prefix(j+2).last
                let operationToEnd = string.substring(from: suffix)
                let stringTmp = string.characters.prefix(j)
                
                if (j != -1 && sign=="+"){
                    if (sign2 != "(") {
                        string = String(stringTmp) + "−" + operationToEnd;
                        j = -1;
                }   else {
                        string = String(string.characters.prefix(j+2)) + "−" + String(string.characters.suffix(length-(j+2)));
                        j = -1;}
                }
                
                if (j != -1 && sign=="−"){
                    if (sign2 != "(") {
                        if (!isNumber(string: String(describing: stringTmp.last)) && stringTmp.last != ")") {
                            string = String(stringTmp) + operationToEnd;
                            j = -1;
                        } else{
                            string = String(stringTmp) + "+" + operationToEnd;
                            j = -1;}
                    }   else {
                        string = String(string.characters.prefix(j+2)) + "−" + String(string.characters.suffix(length-(j+2)));
                        j = -1;}
                }
                
                if (j != -1 && (sign=="×" || sign=="÷")) {
                    if (sign2 != "("){
                        string = String(startToOperation) + "−" + operationToEnd;}//MoiSua
                    else{
                        string = String(string.characters.prefix(j+2)) + "−" + String(string.characters.suffix(length-(j+2)));}
                }
                
                
                
                }
                }
                    
                
            }
            }
        }
            self.lblDisplay.text = string;
    //}

    }

    @IBAction func onclickSolve(_ sender: UIButton) {
        if(string != ""  && !string.contains("=")) {
            let check = string.characters.last;
            if(isAOperation(string: String(describing: check))||check=="."||dem != 0){// Kiểm tra ký tự cuối cùng có phải là toán tử,"." hoặc dấu mở ngoặc không bằng dấu đóng ngoặc
                string=string + "\n" + "="+"ERROR";
                print("Dữ liệu vào không hợp lệ")
            }
            else {
                var stack = Stack<String>();
                var kcats = Stack<String>();
                let a = Infix2Postfix(infix: string);
                var line = a.components(separatedBy: " ")
                print(line)
                for i in 0..<line.count-1 {
                    stack.push(line[i]);
                }
                while (!stack.array.isEmpty) {
                    kcats.push(stack.pop()!);
                }
                let kq = Solve(s: kcats);
                var tmp = ""
                if (kq < 0){
                    tmp =  "−" + String(abs(kq))}
                else{
                    tmp =  String(abs(kq))
                }
                string = string + "\n" + "=" + tmp;
                stack.array.removeAll()
                kcats.array.removeAll()
                
                

            }
            
            
            self.lblDisplay.text = string;
        }

    
    }

    @IBAction func onClickParenthesis(_ sender: UIButton) {
        let length = string.characters.count
        let lastChar = string.characters.last
        if(!string.contains("=")) {
            if (string == "" || length < 52) {// nếu chuỗi là null hoặc nhỏ hơn 52 ký tự (giới hạn 52 ký tự)
                if (length >= 1){
                    if (lastChar=="." || lastChar=="π"){
                        return;}}
                if (string == "") {
                    string = "(";
                    self.lblDisplay.text=string
                    dem=dem+1;// đếm số dấu ngoặc
                    return;
                } else if ((dem == 0 && !isNumber(string: String(describing: lastChar)) && lastChar != ")") || string=="" || isAOperation(string: String(describing: lastChar)) || lastChar=="(") {
                    string = string + "(";
                    dem=dem+1;
                }
                if (dem > 0 && (isNumber(string: String(describing: lastChar)) || lastChar==")")) {
                    string = string + ")";
                    dem=dem-1;
                }
            }
            self.lblDisplay.text=string
            
        }
        else
        {   var tmp:Int;
            tmp = -1
            let s = string.components(separatedBy: "");
            for (index, element) in s.enumerated() {
                if (element=="=") {
                    tmp = index;
                    break;
                }
            }

            if (dem > 0 && (isNumber(string: String(describing: string.characters.prefix(tmp-1).last)) || string.characters.prefix(tmp-1).last==")")) {
                string = String(string.characters.prefix(tmp))+")"
                if (dem != 0){
                    dem=dem-1;}
                }
            else {
                string = "(";
                dem=dem+1;
            }
            
            self.lblDisplay.text=string

        }
    }
    @IBAction func onClickDEL(_ sender: UIButton) {
        let length = string.characters.count
        var tmp:Int;
            tmp = -1;
        if (string != "" && length > 0) {
            let suffix = string.index(string.startIndex, offsetBy: length-1)
            let stringTmp = string.substring(to: suffix)
            let lastChar = Array(string.characters)[length-1]
            if (!string.contains("=")) {
                var j:Int;
                j = -1;
                if (lastChar=="("){
                    dem -= 1;}
                if (lastChar==")"){
                    dem += 1;}
                if (lastChar=="."){
                    flag = true;}
                if (specialChar(string: String(describing: lastChar))) {
                    var s:Array<Character>;
                    s = Array(stringTmp.characters);
                    for (i,e) in s.enumerated().reversed() {
                        if (specialChar(string: String(describing: e))) {
                            j = stringTmp.characters.count - i-1;
                            break;
                        }
                    }
                    if (j != -1) {
                        let suffix2 = stringTmp.index(stringTmp.endIndex, offsetBy: -j)
                        print(stringTmp.substring(from: suffix2))
                        if (!stringTmp.substring(from: suffix2).contains(".")){
                            flag = true;}
                        else{
                            flag = false;}
                    } else{
                        flag = false;}
                }
                let count = lblDisplay.text!.characters.count
                string = String(string.characters.prefix(count-1))
            } else {
                let s = Array(string.characters);
                for (index, element) in s.enumerated() {
                    if (element=="\n") {
                        tmp = index;
                        break;
                    }
                }
                
                string = String(string.characters.prefix(tmp));
                
            }
            //setTextDislay(txv);
            self.lblDisplay.text=string;
            
        }
    }
    @IBAction func onClickOperator(_ sender: UIButton) {
        let inputSign = sender.titleLabel!.text!
        let length = string.characters.count

        //self.lblDisplay.text = string.stringFromHTML("html String")
        if (string == "" || length < 52) {
            if (!string.contains("=")) {// khi chuỗi trên texview không có dấu =
                if(string=="" && (inputSign=="×" || inputSign=="÷"||inputSign=="+"||inputSign=="−"))
                {
                    string = "0" + inputSign;
                    //setTextDislay(txv);
                    self.lblDisplay.text = string
                    return;
                }
                if (length == 1 && string.characters.first=="−"){
                    return}
                if (length>=1) {
                    let lastChar = string.characters.last!
                    let suffix = string.index(string.startIndex, offsetBy: length-1)
                    let stringWithoutLastChar = string.substring(to: suffix)
                    //let count = stringWithoutLastChar.characters.count
                    let ndLastChar = stringWithoutLastChar.characters.last
                    if (lastChar=="."){
                        return;}
                    if (lastChar=="(") {
                        if (inputSign != "−"){
                            return;}
                        else {
                            string = string + inputSign
                            self.lblDisplay.text = string
                            //setTextDislay(txv);
                            return;
                        }
                    }
                    if (lastChar=="−" && (ndLastChar=="×" || ndLastChar=="÷")){
                        return;}
                    if (isAOperation(string: String(lastChar))) {
                        if (inputSign=="−" && lastChar=="−") {
                            string = stringWithoutLastChar + "+";
                            flag = true;
                            
                        } else {
                            if ((lastChar=="×" || lastChar=="÷") && inputSign=="−") {
                                string = string + inputSign;
                                flag = true;
                            } else {
                                string = stringWithoutLastChar + inputSign;
                                flag = true;
                            }
                        }
                        }  else {
                        string = string + inputSign;
                        flag = true;
                    }
                }
            }
            //khi string không tồn tại dấu =;
            else if(string.characters.last != "R" && string.characters.last != "f" ){
                var tmp:Int;
                tmp = -1
                let s = Array(string.characters);
                for (index, element) in s.enumerated() {
                    if (element=="=") {
                        tmp = index;
                        break;
                    }
                }
                let suffixTmp = string.index(string.endIndex, offsetBy: -(length-tmp-1))
                string = string.substring(from: suffixTmp) + inputSign;
                flag = true;
            }
            else
            {
                string="";
                flag=true;
                dem=0;
                if(inputSign=="−"){
                    string=string+"−";}
            }
            self.lblDisplay.text = string
            //setTextDislay(txv);
        }

    }
    @IBAction func onClickClear(_ sender: UIButton) {
        string=""
        flag=true
        dem=0
        self.lblDisplay.text="0"
        self.lblHeader.text = ""
        
    }
    @IBAction func onClickDot(_ sender: UIButton) {
        if ((string=="" || string.characters.count<52)) {

            if (string.characters.count>0){
                if (isAOperation(string:String(describing: string.characters.last))){
                    return;
                }
            }
            if string.contains("="){
                return;
            }
            if (string=="") {
                string = "0" + sender.titleLabel!.text!
                flag = false;
            }
            if (flag == true && isNumber(string:String(describing: string.characters.last))) {
                string = string + sender.titleLabel!.text!
                flag = false;
            }
            //setTextDislay(txv);
            self.lblDisplay.text = string
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func isNumber(string:String)->Bool {

        if (string.contains("0")||string.contains("1")||string.contains("2")||string.contains("3")||string.contains("4")||string.contains("5")||string.contains("6")||string.contains("7")||string.contains("8")||string.contains("9")){
            return true
        }
        return false



    }
  
    
    func isAOperation(string:String)->Bool {
        if (string.contains("+") || string.contains("−") || string.contains("×") || string.contains("÷") || string.contains("^")){
            return true;
        }
        return false;
        
    }
    func specialChar(string:String)->Bool {
        if (string=="+" || string=="−" || string=="×" || string=="÷" || string=="(" || string==")" ||
            string=="^"){
            return true;
        }
        return false;
        
    }
    func GetPriority(op:String)->Int{
        if (op=="^")
        {
            return 3
        }
        if (op=="×"  || op=="÷"){
            return 2;}
        if (op=="+"  || op=="−"){
            return 1;}
        return 0;

    }
    func Infix2Postfix(infix:String)->String{
        let tokens:[String] = processString(str: infix);
        return ProcessConvert(tokens: tokens);

    }
    
    func ProcessConvert(tokens:[String])->String{
        var stack = Stack<String>()
        var result=""
        let count = tokens.count

        for i in 0..<count
        {
            let token = tokens[i];
            if (isAOperation(string: token))
            {
                if ((i == 0) || (i > 0 && (isAOperation(string: tokens[i - 1]) || tokens[i - 1]==("("))))
                {
                    if (token=="−")
                    {
                        result.append(token + tokens[i + 1]);
                        result.append(" ");
                        continue;
                    }
                }
                else
                {
                    while ((!stack.array.isEmpty) && GetPriority(op: token) <= GetPriority(op: stack.peek()!)){
                        result.append(stack.pop()!);
                        result.append(" ");
                    }
                    stack.push(token);
                }
            }
                
            else if (token.contains("(")){
                stack.push(token);}
            else if (token.contains(")"))
            {
                var x = stack.pop();
                while (!(x?.contains("("))!)
                {
                    result.append(x!);
                    result.append(" ");
                    x = stack.pop();
                }
            }
            else// (IsOperand(s))
            {
                result.append(token+" ")
            }
            
        }
        while (!stack.array.isEmpty){
            result.append(stack.pop()!+" ")}
        return result;
    }

    func processString(str:String)->[String]{
        var s1 = "";
        var elementMath:[String]! = [];
        var s=""
        let tmp = Array(str.characters)
        for i in tmp {
            s = s + String(i)
        }
        let a = s.characters.count
        
        if(Array(s.characters)[0]=="−"){
            var i = 2;
            s1 = s1 + "-" + String(Array(s.characters)[1]);
            while i<a {
                let c = Array(s.characters)[i];
                if(c=="−"&&Array(s.characters)[i+1]=="("){
                    if (isAOperation(string: String(Array(s.characters)[i-1]))){
                        s1 = s1 + "-1" + " " + String(Array(s.characters)[i-1]);}
                    else if( i >= 1&&isNumber(string: String(Array(s.characters)[i-1]))){
                        s1 = s1 + " " + "+" + " " + "-1"+" " + "×";}
                    else{
                        s1 = s1 + "-1" + " " + "×";}
                }
                else if((c=="×"||c=="÷")&&Array(s.characters)[i+1]=="−"&&isNumber(string:String(Array(s.characters)[i+2]))) {
                    s1 = s1 + " " + String(c) + " " + "-" + String(Array(s.characters)[i+2]);
                    i = i + 2;
                }
                else if(c=="("&&Array(s.characters)[i+1]=="−"&&isNumber(string: String(Array(s.characters)[i+2]))) {
                    s1 = s1 + " " + String(c) + " " + "-" + String(Array(s.characters)[i+2]);
                    i = i + 2;
                }
                else if (!specialChar(string: String(c))){
                    if(c == "π"){
                        s1 = s1 + String(Double.pi)
                    }
                    else{
                        s1 = s1 + String(c);}
                }
                else {s1 = s1 + " " + String(c) + " ";}
                i=i+1
            }

        }
        else{
        var i = 0;
        while i<a {
                let c = Array(s.characters)[i];
                if(c=="−"&&Array(s.characters)[i+1]=="("){
                    if (isAOperation(string: String(Array(s.characters)[i-1]))){
                        s1 = s1 + "-1" + " " + String(Array(s.characters)[i-1]);}
                    else if( i >= 1&&isNumber(string: String(Array(s.characters)[i-1]))){
                        s1 = s1 + " " + "+" + " " + "-1"+" " + "×";}
                    else{
                        s1 = s1 + "-1" + " " + "×";}
                }
                else if((c=="×"||c=="÷")&&Array(s.characters)[i+1]=="−"&&isNumber(string:String(Array(s.characters)[i+2]))) {
                    s1 = s1 + " " + String(c) + " " + "-" + String(Array(s.characters)[i+2]);
                    i = i + 2;
                }
                else if(c=="("&&Array(s.characters)[i+1]=="−"&&isNumber(string: String(Array(s.characters)[i+2]))) {
                    s1 = s1 + " " + String(c) + " " + "-" + String(Array(s.characters)[i+2]);
                    i = i + 2;
                    }
                else if (!specialChar(string: String(c))){
                    if(c == "π"){
                        s1 = s1 + String(Double.pi)
                    }
                    else{
                    s1 = s1 + String(c);}
                }
                else {s1 = s1 + " " + String(c) + " ";}
                i=i+1
        }
        }

        s1 = s1.condenseWhitespace()
        elementMath=s1.components(separatedBy: " ")
        return elementMath!
        
    }
    func Solve(s:Stack<String>)->Double{
        var tmp = s;
        var stack=Stack<Double>()
        while (!tmp.array.isEmpty) {
            if (tmp.peek()?.isNumber)! {
                stack.push(Double(tmp.pop()!)!);
            } else {
                var y = stack.pop();
                let x = stack.pop();
                if(isNumber(string: String(describing: x)) || String(describing: x).contains("inf")) {
                    let sign = String(describing: tmp.pop())
                    switch (sign) {
                    case let str where str.contains("+"):
                        y = y!+x!;
                        break;
                    case let str where str.contains("−"):
                        y = x! - y!;
                        break;
                    case let str where str.contains("×"):
                        y = y! * x!;
                        break;
                    case let str where str.contains("÷"):
                        y = x! / y!;
                        break;
                    case let str where str.contains("^"):
                        y = pow(x!, y!)
                        break;
                    default:
                        break
                    }
                }
                stack.push(y!);
            }
        }
        
        return stack.pop()!;
    }
}

