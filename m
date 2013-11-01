Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20131031114958.GE1536@x2.net.home>
References: <1382906556-16442-1-git-send-email-kerolasa@iki.fi>
	<1382906556-16442-8-git-send-email-kerolasa@iki.fi>
	<20131031114958.GE1536@x2.net.home>
Date: Fri, 1 Nov 2013 09:29:53 +0000
Message-ID: <CAG27Bk1PKQKbUQqUUDp4jSTH-wUZU-D6Tqe7wX-dpupce27sow@mail.gmail.com>
Subject: Re: [PATCH 07/10] cal: make user request to be part of read-only
 control struct
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 31 October 2013 11:49, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Oct 27, 2013 at 08:42:33PM +0000, Sami Kerola wrote:
>> +struct cal_request {
>> +     int day;
>> +     int month;
>> +     long year;
>> +     int week;
>> +};
>
>  It makes more sense than cal_width :-)
>
>> +                     ctl.req.day = day_in_year(ctl.req.day, ctl.req.month, ctl.req.year);
>
>    req.day = calculate_request_day(&req);
>
>> -static void monthly(int day, int month, long year, const struct cal_control *ctl)
>> +static void monthly(const struct cal_control *ctl)
> ...
>> -     rows = do_monthly(day, month, year, &out, -1, ctl);
>> +     rows = do_monthly(ctl->req.day, ctl->req.month, ctl->req.year, &out, -1, ctl);
>                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  Well, if you have a request struct then use it!
>
>       do_monthly(req, &out, -1, ctl);
>
>
>  Maybe you can keep request and control structs independent, so then
>  one day you can implement something like
>
>     cal --date=Dec-2013 --date=Dec-2014
>
>  to print more independent calendars :-)

Hi Karel, et.al.,

Thank you for comments, they are useful as usual. You pointed out some
things I already knew being suboptimal, and couple new considerations
to me. Fair conclusion is that all ten patches are not in state for
merge.

How about formalizing the process for changes, and document it in
howto-contribute? It could be something like

1. Tell in mail list you are going to work with some particular piece
for long time and with intention to perform great change. This helps
other to avoid massive merge conflicts. Small or quick work does not
need to be announced.
2. Submit only changes that you think are ready to merge. If something
is not ready, but you want it to get comments tell clearly which
patches you want to be treated this way.
3. When getting comments align the changes with them. Notice that
resubmission without changes is as good as ignoring advice, that is
neither recommended nor polite.
4. Resubmission can be partial or complete. If only few alterations
are needed here and there resubmit particular patches. When comments
cause greater effect resubmit everything again. Later is true
especially true in cases when maintainer send comment 'could you
resubmit all when done'.
5. All patch submissions, big or small, will end either to final
reject or merge. When maintainer rejects a patch (series) it is
pointless to resubmit.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
