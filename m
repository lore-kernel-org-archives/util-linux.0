Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:63553 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754510Ab1DZLMX (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Tue, 26 Apr 2011 07:12:23 -0400
Date: Tue, 26 Apr 2011 13:12:28 +0200
From: Karel Zak <kzak@redhat.com>
To: Jan Engelhardt <jengelh@medozas.de>
Cc: util-linux-ng@vger.kernel.org
Subject: Re: Mangle functions
Message-ID: <20110426111228.GF29492@nb.net.home>
References: <alpine.LNX.2.01.1104231718050.16111@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.01.1104231718050.16111@obet.zrqbmnf.qr>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Apr 23, 2011 at 05:20:01PM +0200, Jan Engelhardt wrote:
> I see a mnt_mangle function provided by libmount, but it seems to be 
> meant for *tab columns only. Is there also a function that mangles the 
> passed string such that it can be used as an option value, i.e. encodes 
> the set " ,\t\n\\"?

 Not sure if I good understand. Do you have any example?

 Do you mean mount options? The library uses the mnt_mangle functions
 for all strings that are read/write to/from the *tab files. You don't
 have to care about " \t\n\\".
 
 The problem is comma (','), it should not be used in the strings --
 exception are SELinux mount options where comma is acceptable if the
 option uses quotes (e.g. context="aaa,bbb,ccc").

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
