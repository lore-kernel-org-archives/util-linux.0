Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:10680 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753185Ab3JVPzj (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Tue, 22 Oct 2013 11:55:39 -0400
Date: Tue, 22 Oct 2013 17:55:35 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Tommi Kyntola <tommi.kyntola@gmail.com>, util-linux-ng@vger.kernel.org
Subject: Re: [RFC/PATCH] week numbers for cal
Message-ID: <20131022155535.GI15115@x2.net.home>
References: <CAO2cUkTj+f+6xrgr6+WzY9D+TwwZHWYhMfuMKKYF=39vJ8wU6w@mail.gmail.com>
 <20131022103214.GG15115@x2.net.home>
 <CAG27Bk3+XOmDrSumdaqWn_tTH1OxYQjwfeoaZ0pM8jN6OJuNQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk3+XOmDrSumdaqWn_tTH1OxYQjwfeoaZ0pM8jN6OJuNQA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 22, 2013 at 04:23:22PM +0100, Sami Kerola wrote:
> On 22 October 2013 11:32, Karel Zak <kzak@redhat.com> wrote:
> > On Sat, Oct 05, 2013 at 11:59:54PM +0300, Tommi Kyntola wrote:
> >> I keep trying -w with cal from time to time and I finally decided it's
> >> about time to do something about it. I'm not sure if this is something
> >> you'd be interested in incorporating into util-linux cal, but it's
> >> something I wanted, so here it is. There's gcal of course, but I only
> >> wanted a toothpick not the whole forest.
> >
> > Applied, thanks.
> 
> FYI
> 
> I started think, and play with the cal code, in order to make the source a
> little bit more maintainable.  My plan is to add run time configuration
> and parameters structures. With bit of luck changing data structures
> allows less strange functions.

 That's also my wish. The current source is based on code rather data
 structures. That's alway bad thing, the result is mess of for/if()
 machinery.
 
 It would be nice to describe the problem by structs and split code 
 to two sets of the functions 

        1/ generate calendar(s), 
        2/ print calendar. 
        
  Something like:

  struct cal_week {
        int week_number;
        int days[7];
        ...
  };

  struct cal_month {
        struct cal_week weeks[5];
        ...
  }

  struct cal_control {
        int week_start;
        ...
        struct cal_month cals[12];
  }
 
  cal_new_month();
  cal_add_month();
  cal_get_month();
  cal_month_get_week();
  ...
  cal_print_calendar()

  ... or better.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
