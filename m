Return-Path: elseifthen@gmx.com
Subject: Re: [v3 PATCH 00/11] Pull Request - changelog
To: Karel Zak <kzak@redhat.com>
References: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
 <20180108102159.dyelg7kqp5tx3c3i@ws.net.home>
 <6635776f-9787-f05c-704f-e326808daa1d@gmx.com>
 <20180111090120.k6h5q2juw6gqemlc@ws.net.home>
 <95eb163b-218b-42ab-1b4b-4018cedd040e@gmx.com>
 <20180112105706.plx4c5puj6uxdofw@ws.net.home>
 <6ad5a25b-6095-38f7-65b3-bd2711a05ba3@gmx.com>
 <20180115133622.v4wbionunsjj7bmy@ws.net.home>
 <a638c05f-19dc-513f-51b0-f37937193196@gmx.com>
 <20180117120826.r2xcl25wgf47qex4@ws.net.home>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <c81d29da-4b9b-f924-0592-6e28813e302c@gmx.com>
Date: Thu, 18 Jan 2018 11:32:14 -0500
MIME-Version: 1.0
In-Reply-To: <20180117120826.r2xcl25wgf47qex4@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


On 01/17/2018 07:08 AM, Karel Zak wrote:
> On Tue, Jan 16, 2018 at 04:35:47PM -0500, J William Piggott wrote:
>>> I hope I'll work on cal(1) this week. If you see any bug in the
>>> current code, then fix it again the current master branch. I'll rebase
>>> and merge it to the new code later... or wait ;-)
>>
>> That's not cool Karel. You requested volunteers to do this for you. I've been
>> working on it for nearly a month, and now you want to pull it out from under me.
> 
> Ah, I don't want to say I'll ignore your patches or so. This is
> misunderstanding... anyway merged!
> 
>> I'm submitting 2 patches that implement exactly what you've asked for; all by
>> the book; nothing removed, no short options, etc. Plus one patch to update the
>> man page. If there is something wrong with the submission I'd like some
>> constructive feedback so that I can fix it.
> 
> Yes, sounds good. Thanks! (and thanks for patience with stubborn
> maintainer;-)

Well, it took me 5 versions before coming around. So thank you for your
patience also. Hopefully, in the end, these discussions on various
design options yields the best results.

> I'm not sure about the way how the current cal(1) code handles the
> reform. It's all based on "year", but it could be more complex if we
> want to make it extendable and support another reforms too.

I think this is an important question to answer before making design
choices. Do you want to add more reform dates?

Time keeping is very geopolitical. For example, the tz database
(zoneinfo) is plagued by complaints of political nature like: "you have
county x, y, and z; why do you exclude my country? Why are you treating
us like second class country?"

This has become so frustrating that some contributors are advocating to
strip the db of all geographic connections and label the various
timezones with random hashes.

So do you intend to:

 a) selectively add a few more reform dates and deal with the potentially
    political strife it may bring to the project?

 b) add all reform dates?
     If yes, how would complex regions like Latvia, Netherlands, Sweden,
     and Russia be implemented? (very difficult I think)

 c) do not add any more reform dates?
     Then the reform structs would not be useful.

Currently I think there is a good answer if anyone requested to add more
reform dates:

"The Chesterfield reform is a historical feature of cal(1) and part of
the POSIX standard, so it cannot be removed. We will not be adding any
new reform dates. Reform dates can be examined by having cal display the
date in both the Gregorian and Julian calendar systems."

This is one reason that I thought adding exclusive Julian calendar
output was a good feature; any reform date can be examined. It also
allows regions, other than the 'British Empire" to display their proper
dates. For example, Greece can now view dates prior to 1923-02-16 using
Julian calendars. Of course, this puts the onus of knowing the reform
date on the user.

8< ---

> 
> day_in_week():
>     struct cal_reform *re = ctl->reform;
> 
> 	if (re->year < year
> 	    || (year == re->year && re->month < month)
> 	    || (year == re->year
> 		&& month == re->month && re->day + re->missing_days < day)) {
> 
>         ...
> 	}

This will break for regions like Prussia where the reform crosses a
month boundary.

Also here, and some other places I think:
	month->month == REFORMATION_MONTH &&
	(j == 3 || j == 247))
		j += NUMBER_MISSING_DAYS;


This code I'm not sure about:
	if (year != ctl->reform_year + 1)
		year -= month < MARCH;
	else
		year -= (month < MARCH) + 14;

The first branch is easy; normally Jan and Feb day-of-week are based on
the previous year because of the potential jump on March 1st for leap
years.

The second branch is making a correction for the year following the reform
adoption, because in that case Jan 1 of the previous year would be a
Julian calendar date and won't work. What I'm not sure about is where the
constant '14' derives from. It may be the first day of the new Gregorian
calendar implementation 14 Sept 1752. If so, will simply substituting
other reform dates first_day work? This function is all about leap
years, this branch would impact that. 1752 happens to be a leap year for
both Gregorian and Julian systems. What will happen for regions like
Switzerland where the reform year is a leap year for Gregorian but not
for Julian?

I don't know to what extent, but my instinct is that cal's code is very
specific to 3 Sept 1752 and simply plugging other reform dates into it
will be brittle.

So sure, more reform dates could be added; I think it may be complex to
implement though. I've only given some examples, there are more places
in the code tied to the current reform date.

> IMHO it's better and more readable than the current hardcoded stuff.

True, if the plan is to add more reform dates; otherwise the reform day
could be a preprocessor define like REFORMATION_MONTH,
NUMBER_MISSING_DAYS, and YDAY_AFTER_MISSING are.

> The remaining thing is magic constants for day-in-week calculations.
> It's fast/elegant for Gregorian (ISO) calendar, but I'm not sure about
> old calendars. 

So, the names for the reform[] and old[] arrays are not so good. They
should be gregorian and julian, or just greg and juli. They will work
for any date in there respective calendar systems. Since those are the
only two systems that cal uses, the constants should work as expected.

> Maybe the original calculation before 91ac9ef5db449b38e679e85483f2dc6d9a56e1ce
> has been more readable (based on leap_years_since_year_1() and easy to adopt 
> to another calendars. Ideas?

Not needed, IMO.

> 
>     Karel
> 
> 
