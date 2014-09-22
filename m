Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40679 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752688AbaIVLdw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Sep 2014 07:33:52 -0400
Date: Mon, 22 Sep 2014 13:33:46 +0200
From: Karel Zak <kzak@redhat.com>
To: Gennady Kovshenin <gennady@kovshenin.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Fwd: [util-linux] cal: add landscape layout for yearly views
 (#117)
Message-ID: <20140922113327.GI5366@x2.net.home>
References: <karelzak/util-linux/pull/117@github.com>
 <karelzak/util-linux/pull/117/c55868722@github.com>
 <CAP0zEAb8y+P-McdLc23dJyqG3_=mFQw9PEmkaLLbzGzmWL7p-A@mail.gmail.com>
 <CAP0zEAZhyOqM-VmBkGEA4sN2wC+YycOtP8h6AxytjTDXsw1K4A@mail.gmail.com>
 <20140917131848.GA5366@x2.net.home>
 <CAP0zEAZ9aMs-ky5ivweJoytTn7MvGcq0qyyDnFkk-5iMWRHz0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAP0zEAZ9aMs-ky5ivweJoytTn7MvGcq0qyyDnFkk-5iMWRHz0w@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Sep 17, 2014 at 09:52:36PM +0600, Gennady Kovshenin wrote:
> I like the format=auto idea. But we can keep it to just the number of
> columns instead of a full CxR format.

 It would be the best to talk about number of months ;-)

> i.e. format=2 (2x6), format=3 (3x4), format=4 (4x3), and so on.
> perhaps the parameter should be called --columns/-c instead of format.
> We can either have an additional auto value to the format, or have it
> be on by default.
> Having auto on by default means breaking compatibility. Some users
> might be parsing output expecting the default 3x4 view in place and if
> we abruptly change this to be stretched automatically their scripts
> might break.
> 
> Any thoughts on the above? --format vs. --columns? And the default
> value thereof.

Or something else --horizontal-months[=<num>|auto]

and think we can support arbitrary <num> in range 1-12.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
