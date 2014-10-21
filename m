Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:5204 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752350AbaJUJFX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 21 Oct 2014 05:05:23 -0400
Date: Tue, 21 Oct 2014 11:05:17 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: the option --label-nested of sfdisk
Message-ID: <20141021090517.GE8057@x2.net.home>
References: <1413834738.3279286.181227401.682D2FFB@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1413834738.3279286.181227401.682D2FFB@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 20, 2014 at 09:52:18PM +0200, Benno Schulenberg wrote:
> Recently the option --label-nested (to specify the type of a nested label
> in a GPT) has been added to sfdisk.  But this name, --label-nested, it...
> doesn't sound very English, it is not how one would say this in English.
> 
> Upcoming patch changes it to --nested-label, also because when using
> long options it is enough to use the first few letters of an option to
> choose one unequivocally, but when having both --label and --label-nested
> one can no longer do something like "--lab bsd".  After the patch one can
> do that again, /and/ use "--nest bsd" too, which is short and very clear.
                            ^^^^^^^^^^
The problem is that the original sfdisk version had "--nested" option,
the option is no more supported, but I'd like to avoid misinterpretation.

Anyway, you're right that --label-nested sounds strange.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
