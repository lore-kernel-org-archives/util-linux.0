Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20170613131627.ajcqe2k6gicrtelv@ws.net.home>
References: <20170608195215.1702-1-kerolasa@iki.fi> <20170608195215.1702-6-kerolasa@iki.fi>
 <20170613131627.ajcqe2k6gicrtelv@ws.net.home>
From: Sami Kerola <kerolasa@iki.fi>
Date: Sat, 17 Jun 2017 09:26:46 +0100
Message-ID: <CAG27Bk02_++bpd13byPsVx_yuWo494TT+sPcwg9auzQv61P1+Q@mail.gmail.com>
Subject: Re: [PATCH 05/11] uuidgen: add --date option to display time when
 uuid was generated
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <util-linux.vger.kernel.org>

On 13 June 2017 at 14:16, Karel Zak <kzak@redhat.com> wrote:
> On Thu, Jun 08, 2017 at 08:52:09PM +0100, Sami Kerola wrote:
>> The uuidgen has always had option to use time as a uuid value.  To common
>> users these timestamps have been difficult to convert to readable format, so
>> add an option to do that.
>
> The name of the tool is uuidgen and at first glance it seems like
> --date is a way how to use a different time than the current ;-)
>
> Maybe it would be better to create a small independent tool uuidparse
> and print all available details about UUID (variant, type and time).
>
>  $ uuidparse  7e400110-3e4a-11e7-8af1-00037f500001
>  variant: DCE
>  type: time
>  time: 2017-05-21 17:25:32,471528+0000
>
>  $ uuidparse --time
>  2017-05-21 17:25:32,471528+0000
>
>  It would be also nice to accept more than one UUID on command line/stdin.
>
> or so... Comments?
>
>  See libuuid/src/uuid_time.c where is test program.
>
>> +static int print_uuid_date(char *date)
>> +{
>> +     uuid_t uuid;
>> +     struct timeval tv;
>> +     char buf[ISO_8601_BUFSIZ];
>> +
>> +     if (uuid_parse(date, uuid)) {
>> +             printf(_("invalid uuid: %s\n"), date);
>
>  "failed to parse UUID" sounds better
>
>> +             return 1;
>> +     }
>
> Maybe you want to check UUID type and variant, only DCE time is
> supported.
>
> I think separated pull request would be better ;-)

I thought it would be better avoid adding small binaries, but
no problems I can do that and ensure all the other feedback
is incorporated to that utility as well.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
