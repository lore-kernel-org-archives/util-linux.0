Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32206 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751228Ab3JRI1e (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 18 Oct 2013 04:27:34 -0400
Date: Fri, 18 Oct 2013 10:27:31 +0200
From: Karel Zak <kzak@redhat.com>
To: =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: gettext error
Message-ID: <20131018082731.GA15115@x2.net.home>
References: <525F2FC0.70802@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <525F2FC0.70802@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 17, 2013 at 07:30:56AM +0700, Trần Ngọc Quân wrote:
> $ nsenter --help
> display l10n incorrecttly.
> Fix:
> Change sys-utils/nsenter.c:189 to:
> setlocale(LC_ALL, "");

 Fixed.

> I have a question:
> I will sent rc2 translation, so do I have to sent util-linux-2.24-rc1.vi.po?

 Well, I'm going download the latest translation (newer than the previous u-l
 release) from http://translationproject.org/latest/util-linux/. So, I care 
 more about date then about a version.

 ... and it seems there is already your vi.po. Thanks.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
