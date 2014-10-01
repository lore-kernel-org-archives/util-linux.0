Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:24753 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbaJAHbd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Oct 2014 03:31:33 -0400
Date: Wed, 1 Oct 2014 09:31:28 +0200
From: Karel Zak <kzak@redhat.com>
To: Gennady Kovshenin <gennady@kovshenin.com>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
Subject: Re: Fwd: [util-linux] cal: add landscape layout for yearly views
 (#117)
Message-ID: <20141001073128.GD26272@x2.net.home>
References: <karelzak/util-linux/pull/117@github.com>
 <karelzak/util-linux/pull/117/c55868722@github.com>
 <CAP0zEAb8y+P-McdLc23dJyqG3_=mFQw9PEmkaLLbzGzmWL7p-A@mail.gmail.com>
 <CAP0zEAZhyOqM-VmBkGEA4sN2wC+YycOtP8h6AxytjTDXsw1K4A@mail.gmail.com>
 <20140917131848.GA5366@x2.net.home>
 <CAP0zEAZ9aMs-ky5ivweJoytTn7MvGcq0qyyDnFkk-5iMWRHz0w@mail.gmail.com>
 <20140922113327.GI5366@x2.net.home>
 <CAP0zEAbucyO55YyAhbUkcEB-+R8GQ1qv+XAdQYzp-bo2xB2wjQ@mail.gmail.com>
 <CAG27Bk0XXisYj9=d=RHtHSELc21=JVfyEzqSaTEwTqtLNv+szw@mail.gmail.com>
 <CAP0zEAazGfOpU-90KZNgMcyWs_RVv3QXHape-bRn_sW57sab-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAP0zEAazGfOpU-90KZNgMcyWs_RVv3QXHape-bRn_sW57sab-w@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 23, 2014 at 12:14:31PM +0600, Gennady Kovshenin wrote:
> Karel, how do you feel about the --width -w option?

 --width seems like option with mandatory argument, command line
 without another argument (e.g. "cal --width") seems strange.


 --horizontal[=<months>] where default is "auto" seems better ;-)

> > Then the default geometry 3xN should be applied, unless otherwise
> > defined by user.

 3xN should be be default when no --horizontal is specified.

 cal -y                  ==> 3 columns
 cal --horizontal        ==> depends on terminal width
 cal --horizontal=6      ==> 6 columns

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
