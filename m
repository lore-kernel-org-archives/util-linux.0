Return-Path: <SRS0=pu0z=OT=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709CEC04EB8
	for <util-linux@archiver.kernel.org>; Mon, 10 Dec 2018 12:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C56420821
	for <util-linux@archiver.kernel.org>; Mon, 10 Dec 2018 12:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=openfortress.nl header.i=rick@openfortress.nl header.b="FweWfblE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C56420821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openfortress.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbeLJMrw (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:47:52 -0500
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:44167 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726664AbeLJMrw (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 10 Dec 2018 07:47:52 -0500
Received: from popmini.vanrein.org ([83.161.146.46])
        by smtp-cloud9.xs4all.net with ESMTP
        id WKyOg1LyaMlDTWKyPg5Gcy; Mon, 10 Dec 2018 13:47:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openfortress.nl; 
 i=rick@openfortress.nl; q=dns/txt; s=fame; t=1544446055; 
 h=message-id : date : from : mime-version : to : cc : 
 subject : references : in-reply-to : content-type : 
 content-transfer-encoding : date : from : subject; 
 bh=e8SFJ+uV5LzBbOyY1Is9/wxmMNmlNalB+g4ExyQ4Vio=; 
 b=FweWfblE1Pv/MvbTG8AB6fHOgPkT1ADQFdzn7xy21EHYN9WbOUHnZD85
 A7tqKB2jlrEMmPARtF3vUXih5tGUnoa5DfjTAYxUake0Sib1kehwEDk1hz
 Ohyq7OakCwp864nQho+wFsDN6wbZKjotk/V4NgEl6vyhE+2a70LYWmr4U=
Received: by fame.vanrein.org (Postfix, from userid 1006)
        id 9D7A7278FC; Mon, 10 Dec 2018 12:47:28 +0000 (UTC)
Received: from airhead.local (phantom.vanrein.org [83.161.146.46])
        by fame.vanrein.org (Postfix) with ESMTPA id 218792759F;
        Mon, 10 Dec 2018 12:47:24 +0000 (UTC)
Message-ID: <5C0E6057.5010309@openfortress.nl>
Date:   Mon, 10 Dec 2018 13:47:19 +0100
From:   Rick van Rein <rick@openfortress.nl>
User-Agent: Postbox 3.0.11 (Macintosh/20140602)
MIME-Version: 1.0
To:     Karel Zak <kzak@redhat.com>
CC:     util-linux@vger.kernel.org
Subject: Re: PATCH: script: Introduced a streaming output command
References: <5C090B46.5090200@openfortress.nl> <20181210114634.ee5jamwllimdmrdc@ws.net.home>
In-Reply-To: <20181210114634.ee5jamwllimdmrdc@ws.net.home>
X-Enigmail-Version: 1.2.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bogosity: Unsure, tests=bogofilter, spamicity=0.520000, version=1.2.4
X-CMAE-Envelope: MS4wfFJGVKv1ZV/pxc5AQlMl51AuKf63UCcU/KG6dCTuL4L8sV6eP1QW+2Xzv4Yn5SFPoBHRbS97U0PBVz2hTOJpA6gtVtFOG8RdBP4k5EIStnPwN+ZuySwk
 x5WP/8UYrwkd1W0lu7AHACB8bHH9VxjrSeSCQeS97mlCyT6s2GVejQAcZz3ScvY3ZVVJn2aGssJyEA==
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello Karel,

Thanks for the evaluation.  I will follow your hints on all points, some
are subjective but these are your prerogative.  New patch will come in a
few days.

> Nice idea ;-)

Thanks.  I didn't want to mention a specific online service in the
"real" documentation, but the idea was inspired by "nc seashells.io 1337".

> Do we really need the default command? ;-) 

No, it's merely a luxoury.  One might say that something _around_ script
is another way of doing this.  I will remove it.

> I think the example with nc(1) in the man page is good enough. We do
> not need hardcode any path/name in the code.

OK.  This a matter of taste, I will follow your directions.

> It would be better to use one bit for this boolean,
> 
>   unsigned int
>     stream :1

Yes I agree.  I hadn't noticed that :1 was used on other flags (they're
concentrated below, I see now).  Will change move it into that habit.

>     if (ctl->stream)
>         wait_for_stream_cmd(ctl, 0);
> 
> I guess it would be more robust, than call wait_for_stream_cmd()
> in all situations.


OK, will do.

>> +	int cmdio[2];
> 
> It's detail, but stream_pipe[] wold be more readable :-)

Sure, will do.

>> +			fprintf(stderr,_("streaming command failed: %s\r\n"),strerror(errno));
>> +			exit(1);
> 
>     err(1, _("streaming command failed"));
> 
> err() seems better than fprintf() + strerror() + exit();

I missed that option.  Will do.

> Frankly, all the command-line semantic seems complicated and a little
> bit like over-engineering.

I am trying to make it simple to use, with a minimum of entry (and
manpage reading).  It's a matter of taste, and falls in the same line as
moving the default script from inner command to wrapper around script.
So I'm not going to debate this, and follow your taste.  It's your
software, after all :)


I will post a new patch in a while (and this time I'll be more accurate
about the subject and line breaks while logically occurred in the email
body).
