Return-Path: util-linux-owner@vger.kernel.org
Received: from borg.medozas.de ([188.40.89.202]:45442 "EHLO borg.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755160Ab1DWPUD (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Sat, 23 Apr 2011 11:20:03 -0400
Date: Sat, 23 Apr 2011 17:20:01 +0200 (CEST)
From: Jan Engelhardt <jengelh@medozas.de>
To: kzak@redhat.com
cc: util-linux-ng@vger.kernel.org
Subject: Mangle functions
Message-ID: <alpine.LNX.2.01.1104231718050.16111@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hej,


I see a mnt_mangle function provided by libmount, but it seems to be 
meant for *tab columns only. Is there also a function that mangles the 
passed string such that it can be used as an option value, i.e. encodes 
the set " ,\t\n\\"?

