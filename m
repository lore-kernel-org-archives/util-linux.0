Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33200 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754152Ab3JFSiP (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Sun, 6 Oct 2013 14:38:15 -0400
Message-Id: <1381084694.1334.30658017.687B2CE7@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Tommi Kyntola <tommi.kyntola@gmail.com>
Cc: kerolasa@gmail.com, util-linux-ng@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [RFC/PATCH] week numbers for cal
Date: Sun, 06 Oct 2013 20:38:14 +0200
In-Reply-To: <CAO2cUkRXsUrK=kZsx=yHAKR+Ht2baA5bLiTwU4J9UD4sEbBepg@mail.gmail.com>
References: <CAO2cUkTj+f+6xrgr6+WzY9D+TwwZHWYhMfuMKKYF=39vJ8wU6w@mail.gmail.com>
 <CAG27Bk3APFUnaWq+TzK9p3snpAzZ2v4SBoikB+8HWHaPojZVMQ@mail.gmail.com>
 <CAO2cUkRXsUrK=kZsx=yHAKR+Ht2baA5bLiTwU4J9UD4sEbBepg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sun, Oct 6, 2013, at 19:23, Tommi Kyntola wrote:
> (I fixed some cal related faulty translations from the fi.po while at
> it, although I doubt anyone uses those here)

Most of the things you changed were to "fuzzy" messages, which don't
get used because they were automatically filled in by msgmerge, so they
were not really faulty (in the sense that the translator made a mistake).
I've forwarded your changes to the Finnish transator; with a little luck
the PO file at the translation project will get updated.

One tiny thing: please wrap lines in the man page at around column 70.

Regards,

Benno

-- 
http://www.fastmail.fm - The professional email service

