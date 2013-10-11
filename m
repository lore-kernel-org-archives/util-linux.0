Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:27240 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751044Ab3JKJSR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 11 Oct 2013 05:18:17 -0400
Date: Fri, 11 Oct 2013 11:18:13 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] blockdev: Remove the --setbsz (set blocksize) option
 which has never worked.
Message-ID: <20131011091813.GF14457@x2.net.home>
References: <1381222450-30380-1-git-send-email-rjones@redhat.com>
 <5254113A.2010709@draigBrady.com>
 <20131008140940.GW1887@redhat.com>
 <52542B27.4050901@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <52542B27.4050901@draigBrady.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 08, 2013 at 04:56:23PM +0100, Pádraig Brady wrote:
> So I'm not against removing it. If others wanted to leave it in,
> then it would have to be documented that it was a transient setting.

I have reverted Rich's patch and improved --setbsz docs.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
