Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:45539 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752490AbeDLRQH (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 12 Apr 2018 13:16:07 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: kernel bugzilla entries for util-linux
Date: Thu, 12 Apr 2018 19:15:40 +0200
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <fb5b024f-575b-cbf2-4170-b7c7239946d3@infradead.org>
In-Reply-To: <fb5b024f-575b-cbf2-4170-b7c7239946d3@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201804121915.41262.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 10 April 2018, Randy Dunlap wrote:
> Bug 100021 - [util-linux] v2.24 ... v2.26.2: bug in regression test script for partx

This was fixed in 2.30, commit 3a951379a
