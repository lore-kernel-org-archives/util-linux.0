Return-Path: <SRS0=pu0z=OT=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD6BC04EB8
	for <util-linux@archiver.kernel.org>; Mon, 10 Dec 2018 14:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38562082F
	for <util-linux@archiver.kernel.org>; Mon, 10 Dec 2018 14:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=openfortress.nl header.i=rick@openfortress.nl header.b="UFN9b14G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38562082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openfortress.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeLJOsI (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:48:08 -0500
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:33040 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726888AbeLJOsI (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 10 Dec 2018 09:48:08 -0500
Received: from popmini.vanrein.org ([83.161.146.46])
        by smtp-cloud9.xs4all.net with ESMTP
        id WMqmg2ypBMlDTWMqng63TY; Mon, 10 Dec 2018 15:48:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openfortress.nl; 
 i=rick@openfortress.nl; q=dns/txt; s=fame; t=1544453271; 
 h=message-id : date : from : mime-version : to : cc : 
 subject : references : in-reply-to : content-type : 
 content-transfer-encoding : date : from : subject; 
 bh=vRImzwwqx6mPIijNWgz1PHxESWobYUs+d0LuTlozwnA=; 
 b=UFN9b14GHEL/xt12mBiaal/DXddk2OeX7imJ1JzoGLlijnT/ArjkiXEl
 rFbfvPs8Y3KnSJ91BEQVHkCY5g0jglaJO2LOfm6uVM8Wginm6byraC1fDT
 ShJYBDHGdlaxO7Bkh7iVa6cY9v9N5CvSkVac+NjlDaVOwVJ6rC5lwhkpo=
Received: by fame.vanrein.org (Postfix, from userid 1006)
        id 705CD2792C; Mon, 10 Dec 2018 14:47:44 +0000 (UTC)
Received: from airhead.local (phantom.vanrein.org [83.161.146.46])
        by fame.vanrein.org (Postfix) with ESMTPA id 48AAC275B2;
        Mon, 10 Dec 2018 14:47:44 +0000 (UTC)
Message-ID: <5C0E7C8D.2030307@openfortress.nl>
Date:   Mon, 10 Dec 2018 15:47:41 +0100
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
X-CMAE-Envelope: MS4wfP1ooOufhAR1VrFcowxcXjUjJC6IoUunElGepU+YARnacvnhEs5h1vkRobR4xI8uIt4EJdyVQ3PsC8cyyvWsHzbhLTsCp2afWOP1gGD4bHZQaGu7UQlB
 X0QJZ7hkE7LMLLhicv0gRAfjss19638+xmBmkRMLDLPUUDWvSJdYAQxDL75N1mupyVoa2uuf5uG33Q==
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Karel,

>>  #define DEFAULT_TYPESCRIPT_FILENAME "typescript"
>> +#define DEFAULT_TYPESCRIPT_COMMAND  "scriptstream"
> 
> Do we really need the default command? ;-) 

Trying without, but then users end up typing things like

script -s -- nc -q0 seashells.io 1337 | sed 's/$/\\r/'

There's a lot that can go wrong, and I would complain about that kind of
interactive experimentation and required shell trickery.  That's why I
proposed to capture these problems in a default command and issue

script -s

Alternatively, we can expect users to wrap such complexity around script
and invent their own little tools.  What --stream adds over piping is
then limited, still better but to me it feels incomplete.  I haven't
tested if it works at all, isatty() inside scripts and such.

Your choice?

-Rick
