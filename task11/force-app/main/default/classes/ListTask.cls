public class ListTask {
    public static void SortList(){
        List<Integer> numbersAsc = new List<Integer>{5,3,1,7,9,2,3,4,10};
        numbersAsc.sort();
        List<Integer> numbers = new List<Integer>{5,3,1,7,9,2,3,4,10};
        List<Integer> numbersDesc = new List<Integer>();
        numbers.sort();
        for(Integer i = numbers.size() - 1; i >= 0; i--){
            numbersDesc.add(numbers[i]);
        }
        System.debug('Desc: ' + numbersDesc);
        System.debug('Asc: ' + numbersAsc);
    }
    public static Boolean VerifyFruits(String fruitName, List<String> fruitList){
        fruitName= fruitName.toLowerCase();
        for(Integer i=0; i<fruitList.size(); i++){
            fruitList[i]=fruitList[i].toLowerCase();
        }
        return fruitList.contains(fruitName);
    }
    public static Boolean CompareList(List<Integer> list1, List<Integer> list2){
        if(list1.size()==list2.size()){
            for(Integer i=0; i<list1.size(); i++){
                if(list1[i] != list2[i]){
                    return false;
                }                
            }
            return true;
        }else {
           return false; 
        }
    }
    public static void RemoveDuplicates(List<Integer> listWithDuplicates){
            
        Set<Integer> mySet = new Set<Integer>(listWithDuplicates);
        
        List<Integer> listWithoutDuplicates = new List<Integer>(mySet);
        
        System.debug('List with duplicates: ' + listWithDuplicates);
        System.debug('List without duplicates: ' + listWithoutDuplicates);

    }
    public static void MapOfLists(){
        Map<Integer,List<String>> myMap = new Map<Integer,List<String>>();
        myMap.put(1,new List<String>{'Mert','Ozdemir','Male','+901234567890'});
        myMap.put(2,new List<String>{'Lisa','Jones','Female','+9012334537890'});
        myMap.put(3,new List<String>{'John','Brown','Male','+901234523490'});
        System.debug(myMap);
    }
}