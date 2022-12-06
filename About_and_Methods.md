About

Site Navigation/User-interface
	Each of the tabs at the top of the screen contain separate sections of the project. The ‘METHODOLOGY’  tab describes the process and progress of the site. It shares information regarding how the site was developed, research conducted, and the visual development of the research analysis. The ‘TEXT’ tab contains the relevant text from War and Peace that is being compared to the musical score of Nastasha, Pierre,and the Great Comet of 1812 (under the ‘MUSIC’ tab). (add stuff in about text and music navigation) The ‘ANALYSIS’ tab features the results and conclusions of the study through generated visualization and prose. 


Background
	Originating from Leo Tolstoy’s War and Peace, “Natasha, Pierre, and the Great Comet of 1812” is a musical adaptation following the eighth part within Tolstoy’s most famous work.  As one of the many musicals that follows the pipeline of best-seller to Broadway, a person must ask oneself how this production made its way to the stage despite the convoluted storylines it contains. 
    The production began its Broadway run in November of 2016 as a tremendous hit, receiving 12 Tony award nominations (including Best Musical, Best Original Score, and Best Book of a Musical) and winning two awards (Best Scenic Design and Best Lighting Design). The musical then proceeded to close less than a year later. However, the history of the musical began long before its mark on Broadway, starting with its first run in 2012 off-Broadway. Going even further back, specifically 143 years, was the first publishing of the novel in its entirety. 
    Though the musical only focuses on part eight of War and Peace, the novel as whole narrates the tale of a turbulous Russia. The story follows a slew of aristocratic characters as they make their way through the French invasion of Russia and the Napoleonic Era’s impact on the following Tsarist regimes. The eighth part of the novel, from which Natasha, Pierre, and the Great Comet of 1812 is derived, is about the complications and trials of romance and searching for the meaning of life, as portrayed by the vast array of characters.  
    This project takes a look at the section of the book from which the musical is derived as well as the musical itself, and the overlap that exists between the two works. How much of the musical was taken from the book? How often are overlapping characters referred to/mentioned in both the book and the musical? How are certain characters addressed by other characters in the musical versus the novel? These are the questions this project strives to answer through use of XML and MEI (Music Encoding Initiative) to markup the texts and score, as well as SVG to conduct and visualize our research (for more information about project development, see the methods section).
	

Russian Naming Conventions
    The works used in this project include Russian names, containing multiple forms. These forms consist of, but are not limited to a given name, family name (dependent on the individual’s gender), patronymic (formed from the father’s name), and nickname. This project looks at the frequency of character referral by specific characters and which name form is used to address them. 

Bibliography (will be completed later)

Developers (taken from site)

Methodology

Book Markup
	The book markup began with XML tagging through use of regular expressions. All characters were tagged through regular expressions and then manually after for nicknames/mentions that might have been missed in the regular expressions. Each character was given an attribute that aligns with the musical markup. A schema was developed to ensure the validity of the markup, as well as group character names. As mentioned in the Russian Naming Conventions section in the ‘ABOUT’ tab, the characters in the novel are referred to as multiple names depending on who addresses them. The text of War and Peace was found online at (...) and already contained markup of the text including books, book titles, chapter, chapter titles, paragraphs, and quotations. 

Musical Markup
	The musical markup consisted of XML tagging of the speakers, stanzas, choruses/verses, characters, spoken action, references to War and Peace through use of regular expressions. A schema was developed to ensure the validity of the markup and group character names, similar to the book markup. The musical lyrics were found online at (...) and already contained (...).

Music Player (will be completed once I receive info from Mikey)
	
XSLT (will be completed once portion is uploaded)

SVG (will be completed once portion is uploaded)
