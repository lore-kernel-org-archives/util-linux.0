Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38334 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752215AbbEEKuU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 5 May 2015 06:50:20 -0400
Date: Tue, 5 May 2015 12:50:19 +0200
From: Karel Zak <kzak@redhat.com>
To: Michael Marineau <michael.marineau@coreos.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libfdisk: (gpt) add API for raw partition attributes
Message-ID: <20150505105019.GE27969@ws.net.home>
References: <1430607168-3783-1-git-send-email-michael.marineau@coreos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430607168-3783-1-git-send-email-michael.marineau@coreos.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, May 02, 2015 at 03:52:48PM -0700, Michael Marineau wrote:
> The existing APIs can only toggle individual bits or get and set bits in
> a complex text representation, making it impractical to use libfdisk for
> manipulating the GPT partition attribute field in more complex ways such
> as updating a value that is multiple bits wide. For example priority
> based partition selection originally designed for ChromeOS includes two
> integer values that are 4-bits wide.

 Hmm... my goal is to minimize number of label specific functions, but
 GPT attributes is so specific that it makes sense to export it by API.

 Applied, thanks (and extra thanks for the test!).

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
