Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36291 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbbGOPMc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 15 Jul 2015 11:12:32 -0400
Received: by widjy10 with SMTP id jy10so2667446wid.1
        for <util-linux@vger.kernel.org>; Wed, 15 Jul 2015 08:12:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150715150949.GA28525@angus-think.wlc.globallogic.com>
References: <alpine.DEB.2.02.1507141610310.21273@brickies>
	<20150715134234.GC31997@ws.net.home>
	<alpine.DEB.2.02.1507151055540.30147@brickies>
	<20150715150949.GA28525@angus-think.wlc.globallogic.com>
Date: Wed, 15 Jul 2015 18:12:31 +0300
Message-ID: <CAMw6YJJVpeRSkPM-9CtajNX+T0i2U18H0Mdeq4XAJHK=z9FLpA@mail.gmail.com>
Subject: Re: GPT writing of unknown partition uuids
From: Vadim Kochan <vadim4j@gmail.com>
To: Scott Moser <smoser@ubuntu.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

oops wrong place ...

On Wed, Jul 15, 2015 at 6:09 PM, Vadim Kochan <vadim4j@gmail.com> wrote:
> On Wed, Jul 15, 2015 at 10:56:48AM -0400, Scott Moser wrote:
>> On Wed, 15 Jul 2015, Karel Zak wrote:
>>
>> > On Tue, Jul 14, 2015 at 04:16:56PM -0400, Scott Moser wrote:
>> > > It seems like if the user provided you with a GUID, sfdisk should trust
>> > > them, or at very least exit failure if it refuses to use the provided
>> > > GUID.
>> > >
>> > > Thoughts?
>> >
>> > It's bug, the "unknown" partition type is expected. Fixed in git tree:
>> >
>> > # sfdisk -ql /dev/sdc
>> > Device     Start     End Sectors  Size Type
>> > /dev/sdc1   2048 1023966 1021919  499M Linux filesystem
>> >
>> >
>> > # sfdisk --part-type /dev/sdc 1 $(uuidgen)
>> > ...
>> >
>> >
>> > # sfdisk -ql /dev/sdc
>> > Device     Start     End Sectors  Size Type
>> > /dev/sdc1   2048 1023966 1021919  499M unknown
>> >
>> >
>> > Thanks for your report!
>> Thanks for the quick fix.
>>
>> Is it sane for me to assume this is fixed in any version of
>>   util-linux > 2.26.2 ?
>> --
>> To unsubscribe from this list: send the line "unsubscribe util-linux" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Would you please test a following fix ?
>
> diff --git a/misc/ss.c b/misc/ss.c
> index 03f92fa..3a826e4 100644
> --- a/misc/ss.c
> +++ b/misc/ss.c
> @@ -683,8 +683,8 @@ static inline void sock_addr_set_str(inet_prefix *prefix, char **ptr)
>
>  static inline char *sock_addr_get_str(const inet_prefix *prefix)
>  {
> -    char *tmp ;
> -    memcpy(&tmp, prefix->data, sizeof(char *));
> +    char *tmp;
> +    memcpy(&tmp, &prefix->data[0], sizeof(char *));
>      return tmp;
>  }
>
