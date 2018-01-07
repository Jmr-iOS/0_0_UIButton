/************************************************************************************************************************************/
/** @file       ViewController.swift
 *  @project    0_0 - UIButton
 *  @brief      generation and use of UIButtons with response to button events
 *  @details    x
 *
 *  @author     Justin Reina, Firmware Engineer, Jaostech
 *  @created    11/18/17
 *  @last rev   1/7/18
 *
 *  @section    Reference
 *      http://iphonedev.tv/blog/2014/1/22/programmatic-uibutton-on-ios-70-create-a-uibutton-with-code
 *      http://iphonedev.tv/blog/2014/8/4/create-a-uibutton-in-code-with-objective-c?utm_source=iPhoneDevtv&utm_medium=blog&utm_term=Button%20Tutorial&utm_campaign=ProgramaticUIButtoniOS7
 *      http://stackoverflow.com/questions/24046898/how-do-i-create-a-new-swift-project-without-using-storyboards
 *      http://stackoverflow.com/questions/24030348/how-to-create-a-button-programmatically
 *      http://stackoverflow.com/questions/24102191/make-a-uibutton-programatically-in-swift
 *
 *  @section    Opens
 *      toggle control states it with a second button tap
 *
 *  @section    Legal Disclaimer
 *      All contents of this source file and/or any other Jaostech related source files are the explicit property of Jaostech
 *      Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class ViewController: UIViewController {
    
    //UI
    var buttonOne:UIButton!;
    var buttonTwo:UIButton!;
    var popupView  : UIView!;
    
    //Constants
    let popupHeight : CGFloat = 300;
    
    /********************************************************************************************************************************/
    /** @fcn        override func viewDidLoad()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view.translatesAutoresizingMaskIntoConstraints = false;
        
        let type:UIButtonType = UIButtonType.roundedRect;                           /* (normal)                                     */
        //let type:UIButtonType = UIButtonType.System;                              /* (sys)                                        */
        
        //Gen Popup
        genPopup();
        
        //Buton Init
        buttonOne = UIButton(type: type);
        
        buttonOne.translatesAutoresizingMaskIntoConstraints = true;                 /* must be true for center to work              */
        
        
        //Button Display Text
        buttonOne.setTitle("Test Button - Normal",      for: UIControlState());
        buttonOne.setTitle("Test Button - Disabled",    for: UIControlState.disabled);
        buttonOne.setTitle("Test Button - Focused",     for: UIControlState.focused);
        buttonOne.setTitle("Test Button - Highlighted", for: UIControlState.highlighted);
        buttonOne.setTitle("Test Button - Selected",    for: UIControlState.selected);
        
        
        //Design
        buttonOne.backgroundColor = UIColor.green;
        
        //placement & size
        buttonOne.sizeToFit();
        buttonOne.center = CGPoint(x: self.view.center.x, y: 100);              /* must call after it's sized or won't work!        */
        
        //actions
        buttonOne.addTarget(self, action: #selector(ViewController.pressed(_:)), for:  .touchUpInside);
        
        //add buttonOne
        self.view.addSubview(buttonOne);
        
        //Add buttonTwo
        addSecondButton();
        
        print("ViewController.viewDidLoad():       viewDidLoad() complete");
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        pressed(_ sender: UIButton!)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    @objc func pressed(_ sender: UIButton!) {
        
        sender.sizeToFit(); //adjust to new size! This kinda works. The true full solution is complicated, this shows how to get there...
        
        print("ViewController.pressed():           \(sender.titleLabel!.text!) was pressed");
        
        return;
    }
    
    
/************************************************************************************************************************************/
/*                                                        Second Button                                                             */
/************************************************************************************************************************************/
    
    
    /********************************************************************************************************************************/
    /** @fcn        addSecondButton()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    @objc func addSecondButton() {
        
        //Buton Init
        buttonTwo = UIButton(type: UIButtonType.roundedRect);
        
        buttonTwo.translatesAutoresizingMaskIntoConstraints = true;                         //must be true for center to work
        
        buttonTwo.setTitle("Second Button",      for: UIControlState());
        
        //size & loc
        buttonTwo.sizeToFit();
        
        let newY : CGFloat = buttonOne.frame.origin.y + buttonOne.frame.height + (buttonTwo.frame.height/2)+50;
        
        buttonTwo.center = CGPoint(x: self.view.center.x, y: newY);
        
        buttonTwo.setBackgroundImage(UIImage(named:"greyButton"), for: UIControlState());   //set image after sizeToFit() so it's sized to text and not the huge PNG!
        buttonTwo.setBackgroundImage(UIImage(named:"greenButton"), for: UIControlState.highlighted);
        
        buttonTwo.addTarget(self, action: #selector(ViewController.secondPressed(_:)), for:  .touchUpInside);
        
        self.view.addSubview(buttonTwo);
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        secondPressed(_ sender: UIButton!)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    @objc func secondPressed(_ sender: UIButton!) {
        
        //adjust to new size. This one works!
        buttonOne.sizeToFit();
        
        //Slide subview in
        popupSlide();
        
        print("ViewController.secondPressed():     \(sender.titleLabel!.text!) was pressed");
        
        return;
    }
    
    
/************************************************************************************************************************************/
/*                                                          Popup View                                                              */
/************************************************************************************************************************************/

    /********************************************************************************************************************************/
    /** @fcn        genPopup()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func genPopup() {
        
        //Popup View (from bottom)
        popupView = UIView();
        popupView.backgroundColor = UIColor(red: 83/255, green: 90/255, blue: 102/255, alpha: 1);
        
        let someLabel : UILabel = UILabel(frame: CGRect(x:0,y:0,width:self.view.frame.width,height:25));
        someLabel.font  =   UIFont(name: "HelveticaNeue", size: 17);
        someLabel.text  =   "Second Button was pressed";
        someLabel.textColor     = UIColor.white;
        someLabel.textAlignment = NSTextAlignment.center;
        
        popupView.addSubview(someLabel);
        
        popupView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: self.view.frame.width, height: popupHeight);
        
        self.view.addSubview(self.popupView);
        
        print("ViewController.genPopup():          popup generation complete");
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        popupSlide()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func popupSlide() {
        
        //Check if raised
        let isRaised = (popupView.frame.origin.y < UIScreen.main.bounds.height);
        
        //Animate entry into view
        let options = UIViewAnimationOptions.transitionCrossDissolve;
        var yFrame  = UIScreen.main.bounds.height-self.popupHeight;
        
        if(isRaised) {
            yFrame = (UIScreen.main.bounds.height + 50);                    /* set to offscreen                                     */
        }
        
        let frame   = CGRect(x: 0, y: yFrame, width: self.view.frame.width, height: popupHeight);
        
        
        UIView.animate(withDuration: 1.0, delay: 0.5, options: options, animations: {
            self.popupView.frame = frame;
            if(isRaised) {                                                  /* prev state                                           */
                print("ViewController.genPopup():          sliding popup out!");
            } else {
                print("ViewController.genPopup():          sliding popup in!");
            }
        }, completion: { (finished: Bool) -> Void in
            print("ViewController.genPopup():          sliding popup complete!");
        });
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        override func didReceiveMemoryWarning()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        return;
    }
}

