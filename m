Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752228AbeAQMIa (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 17 Jan 2018 07:08:30 -0500
Date: Wed, 17 Jan 2018 13:08:26 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [v3 PATCH 00/11] Pull Request - changelog
Message-ID: <20180117120826.r2xcl25wgf47qex4@ws.net.home>
References: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
 <20180108102159.dyelg7kqp5tx3c3i@ws.net.home>
 <6635776f-9787-f05c-704f-e326808daa1d@gmx.com>
 <20180111090120.k6h5q2juw6gqemlc@ws.net.home>
 <95eb163b-218b-42ab-1b4b-4018cedd040e@gmx.com>
 <20180112105706.plx4c5puj6uxdofw@ws.net.home>
 <6ad5a25b-6095-38f7-65b3-bd2711a05ba3@gmx.com>
 <20180115133622.v4wbionunsjj7bmy@ws.net.home>
 <a638c05f-19dc-513f-51b0-f37937193196@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a638c05f-19dc-513f-51b0-f37937193196@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 16, 2018 at 04:35:47PM -0500, J William Piggott wrote:
> > I hope I'll work on cal(1) this week. If you see any bug in the
> > current code, then fix it again the current master branch. I'll rebase
> > and merge it to the new code later... or wait ;-)
> 
> That's not cool Karel. You requested volunteers to do this for you. I've been
> working on it for nearly a month, and now you want to pull it out from under me.

Ah, I don't want to say I'll ignore your patches or so. This is
misunderstanding... anyway merged!

> I'm submitting 2 patches that implement exactly what you've asked for; all by
> the book; nothing removed, no short options, etc. Plus one patch to update the
> man page. If there is something wrong with the submission I'd like some
> constructive feedback so that I can fix it.

Yes, sounds good. Thanks! (and thanks for patience with stubborn
maintainer;-)


I'm not sure about the way how the current cal(1) code handles the
reform. It's all based on "year", but it could be more complex if we
want to make it extendable and support another reforms too. This is
what I'd like to change.

The ideal would be to describe the reform by any struct (as good
programming is about data structures rather than about code:-).


struct cal_reform {
    int year;
    int month;
    int day;
    int missing_days;
};

static const struct reforms[] = {
    [REFORM_GB_1752] = { 
        .year = 1752,
        .month = SEPTEMBER,
        .day = 2,
        .missing_days = 11
    },
    [REFORM_GREEK_1923] = {
        .year = 1923,
        .month = FEBRUARY,
        .day = 16,
        .missing_days = 12
    }
    ...
};

/*
 * Names and aliases used in --help output and for getopt()
 */
struct cal_reform_names {
    const char *name;
    int id;
    const char *desc;
};

static const struct reform_names[] = {
    { "1752", REFORM_GB_1752, _N("British Empire reform (September 1752)")_ },
    ...
};


main():
    ctl.reform = &reforms[REFORM_GB_1752];
...


day_in_week():
    struct cal_reform *re = ctl->reform;

	if (re->year < year
	    || (year == re->year && re->month < month)
	    || (year == re->year
		&& month == re->month && re->day + re->missing_days < day)) {

        ...
	}

Comments? 

IMHO it's better and more readable than the current hardcoded stuff.


The remaining thing is magic constants for day-in-week calculations.
It's fast/elegant for Gregorian (ISO) calendar, but I'm not sure about
old calendars. 

Maybe the original calculation before 91ac9ef5db449b38e679e85483f2dc6d9a56e1ce
has been more readable (based on leap_years_since_year_1() and easy to adopt 
to another calendars. Ideas?

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
