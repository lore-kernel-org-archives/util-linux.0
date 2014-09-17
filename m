Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:63341 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755353AbaIQNSw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 17 Sep 2014 09:18:52 -0400
Date: Wed, 17 Sep 2014 15:18:48 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Gennady Kovshenin <gennady@kovshenin.com>
Subject: Re: Fwd: [util-linux] cal: add landscape layout for yearly views
 (#117)
Message-ID: <20140917131848.GA5366@x2.net.home>
References: <karelzak/util-linux/pull/117@github.com>
 <karelzak/util-linux/pull/117/c55868722@github.com>
 <CAP0zEAb8y+P-McdLc23dJyqG3_=mFQw9PEmkaLLbzGzmWL7p-A@mail.gmail.com>
 <CAP0zEAZhyOqM-VmBkGEA4sN2wC+YycOtP8h6AxytjTDXsw1K4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAP0zEAZhyOqM-VmBkGEA4sN2wC+YycOtP8h6AxytjTDXsw1K4A@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Sep 17, 2014 at 06:22:36PM +0600, Gennady Kovshenin wrote:
> I don't think the filling in the terminal completely is a logical
> approach. I feel that calendar year output has to be rectangular. T
> here are always 12 months and the only way to arrange them into a
> nice rectangular shape is 1x12, 2x6, 3x4, 4x3, 6x2, 12x1, other shapes
> don't make much sense UI-wise, do they? All the printed mini calendars
> I get are always laid out in 3x4, 4x3 or 6x2 (rare).

 Well, "fill-in all terminal horizontally" does not mean that I want to
 generate any unreadable mess :-)

 I'd like to see "cal --landscape" *just works* and it automatically
 selects the best output format (3x4, 4x3, 6x2, ...) which fits into
 the current terminal width. That's all the story. As user I don't
 want to think about number of -l options.

 Additionally we can add a new option --format={3x4, 4x3, auto, ...}
 to provide full control on the output for scripts that generate
 something from cal(1) output.

 IMHO, it's mistake that for example -y or -3 ignores terminal width
 so on small terminals it's unreadable.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
