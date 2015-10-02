Return-Path: priahuja321@gmail.com
MIME-Version: 1.0
In-Reply-To: <20151001125840.GF1787@ws.net.home>
References: <CAGQyBevyqMbq6KuRi5=E_QnXmjE4BK7P=sK4awostLf5uNiYuA@mail.gmail.com>
	<20151001125840.GF1787@ws.net.home>
Date: Fri, 2 Oct 2015 11:43:30 -0700
Message-ID: <CAGQyBevj8+L6rMigOXQQw7t=iR9s-PMbbOLf40wu=P7212dCMw@mail.gmail.com>
Subject: Re: Custom structured data from logger utility
From: Priya Ahuja <priahuja321@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Ruediger Meier <ruediger.meier@ga-group.nl>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

Thanks for the changes. Is there a reason for keeping pre-set
structured data elements like timeQuality, tzKnown if custom data is
provided? Also if the SD-ID is the same, it would make more sense
merging the structured data into one, what do you think?

Thanks,
Priya Ahuja

On Thu, Oct 1, 2015 at 5:58 AM, Karel Zak <kzak@redhat.com> wrote:
> On Fri, Sep 18, 2015 at 04:25:29PM -0700, Priya Ahuja wrote:
>> I am using version 2.20.1 logger utility to send logs to rsyslogd from
>> bash scripts. I want to send logs in RFC5424 format with custom
>> structured data fields, example: [sdid@enterprise-number level=INFO
>> id=1234]. I understand 2.20.1 does not support 5424 format but I
>> looked at the logger.c code in the latest version and seems structured
>> data fields are set to [timeQuality tzKnown=\"1\" isSynced=\"1\"
>> syncAccuracy=\"%ld\"]. Is there a way/plan to format custom structured
>> data?
>
> Implemented, for example:
>
>      logger --rfc5424 --sd-id zoo@123                \
>                       --sd-param tiger=\"hungry\"    \
>                       --sd-param zebra=\"running\"   \
>                       --sd-id manager@123            \
>                       --sd-param onMeeting=\"yes\"   \
>                       "this is message"
>
> produces:
>
>      <13>1 2015-10-01T14:07:59.168662+02:00 ws kzak - - [timeQuality tzKnown="1" isSynced="1" syncAccuracy="218616"][zoo@123 tiger="hungry" zebra="running"][manager@123 onMeeting="yes"] this is message
>
>
> The implementation also allows to specify standardized SD-ELEMENTs like
> origin, meta and timeQuality (then build-in timeQuality is disabled).
>
> It would be nice to test it against some advanced syslog.
>
>     Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
