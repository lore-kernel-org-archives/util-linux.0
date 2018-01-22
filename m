Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751020AbeAVLrC (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 22 Jan 2018 06:47:02 -0500
Date: Mon, 22 Jan 2018 12:46:58 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [v3 PATCH 00/11] Pull Request - changelog
Message-ID: <20180122114658.mjqrln5hcae4uehv@ws.net.home>
References: <20180108102159.dyelg7kqp5tx3c3i@ws.net.home>
 <6635776f-9787-f05c-704f-e326808daa1d@gmx.com>
 <20180111090120.k6h5q2juw6gqemlc@ws.net.home>
 <95eb163b-218b-42ab-1b4b-4018cedd040e@gmx.com>
 <20180112105706.plx4c5puj6uxdofw@ws.net.home>
 <6ad5a25b-6095-38f7-65b3-bd2711a05ba3@gmx.com>
 <20180115133622.v4wbionunsjj7bmy@ws.net.home>
 <a638c05f-19dc-513f-51b0-f37937193196@gmx.com>
 <20180117120826.r2xcl25wgf47qex4@ws.net.home>
 <c81d29da-4b9b-f924-0592-6e28813e302c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c81d29da-4b9b-f924-0592-6e28813e302c@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 18, 2018 at 11:32:14AM -0500, J William Piggott wrote:
> > I'm not sure about the way how the current cal(1) code handles the
> > reform. It's all based on "year", but it could be more complex if we
> > want to make it extendable and support another reforms too.
> 
> I think this is an important question to answer before making design
> choices. Do you want to add more reform dates?

It seems on many places Gregorian calendar have been adopted in
previous century so I guess it could be interesting to get appropriate
dates for actors, novelists, painters, researchers, etc... 

The feature seems unique and we already need to support it for GB.

> Time keeping is very geopolitical. For example, the tz database
> (zoneinfo) is plagued by complaints of political nature like: "you have
> county x, y, and z; why do you exclude my country? Why are you treating
> us like second class country?"

Oh, all history of this project is proof that we're able to be distro,
ethnic, language, etc. independent. I've spent many (Red Hat paid)
weeks to make things usable for almost everyone.  If anyone will blame me
for any political games I will very quickly redirect him to very dark
places... ;-)

>  b) add all reform dates?
>      If yes, how would complex regions like Latvia, Netherlands, Sweden,
>      and Russia be implemented? (very difficult I think)

Well, we can add what we have information about the reform. We don't
have to add "all" from the beginning. The another stuff could be added
later. It's open source, "send patch" is valid reaction :-)

    --reform <year>-<region> | <alias>

where <region> is name of the area in time the reform has been
implemented.

    --reform 1600-prussia
    --reform 1648-alsace

and we can add aliases

    --reform 1600-germany

btw, it's already controversial for GB too, it's "Great Britain and
colonies", I guess that some people can feel uncomfortable that
their region is "colonies" :-)

> "The Chesterfield reform is a historical feature of cal(1) and part of
> the POSIX standard, so it cannot be removed. We will not be adding any
> new reform dates. Reform dates can be examined by having cal display the
> date in both the Gregorian and Julian calendar systems."
> 
> This is one reason that I thought adding exclusive Julian calendar
> output was a good feature; any reform date can be examined. It also
> allows regions, other than the 'British Empire" to display their proper
> dates. For example, Greece can now view dates prior to 1923-02-16 using
> Julian calendars. Of course, this puts the onus of knowing the reform
> date on the user.

Yes, this is possible way. I think all the question is if we
want to invert man power to this feature. We can also end this
discussion with "it would be nice ... let's add to TODO" ;-)

> > 	if (re->year < year
> > 	    || (year == re->year && re->month < month)
> > 	    || (year == re->year
> > 		&& month == re->month && re->day + re->missing_days < day)) {
> > 
> >         ...
> > 	}
> 
> This will break for regions like Prussia where the reform crosses a
> month boundary.

Well, it was example, no attempt to implement it ;-)

> 	if (year != ctl->reform_year + 1)
> 		year -= month < MARCH;
> 	else
> 		year -= (month < MARCH) + 14;
> 
> The first branch is easy; normally Jan and Feb day-of-week are based on
> the previous year because of the potential jump on March 1st for leap
> years.
> 
> The second branch is making a correction for the year following the reform
> adoption, because in that case Jan 1 of the previous year would be a
> Julian calendar date and won't work. What I'm not sure about is where the
> constant '14' derives from. It may be the first day of the new Gregorian
> calendar implementation 14 Sept 1752. If so, will simply substituting
> other reform dates first_day work? This function is all about leap
> years, this branch would impact that. 1752 happens to be a leap year for
> both Gregorian and Julian systems. What will happen for regions like
> Switzerland where the reform year is a leap year for Gregorian but not
> for Julian?

Well, all the reform is just jump in calendar, from one day to
another, from one calculation method to another. The current code mix
it together, but is it really necessary? I guess you can just jump in
time and start use Gregorian calendar independently on the previous
Julian stuff (independently on leap year, etc.).

> I don't know to what extent, but my instinct is that cal's code is very
> specific to 3 Sept 1752 and simply plugging other reform dates into it
> will be brittle.

Yes, I agree the current code is very 1752-centric (and it's not too
elegant ;-)

> > The remaining thing is magic constants for day-in-week calculations.
> > It's fast/elegant for Gregorian (ISO) calendar, but I'm not sure about
> > old calendars. 
> 
> So, the names for the reform[] and old[] arrays are not so good. They
> should be gregorian and julian, or just greg and juli. They will work
> for any date in there respective calendar systems. Since those are the
> only two systems that cal uses, the constants should work as expected.

I read again https://en.wikipedia.org/wiki/Determination_of_the_day_of_the_week#T.C3.B8ndering.27s_algorithm
and it makes more sense for me now. So, this is no problem.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
