Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: partx: deleting single partitions fails
Date: Thu, 15 Jun 2017 13:55:47 +0200
Cc: util-linux@vger.kernel.org
References: <201706141243.11785.sweet_f_a@gmx.de> <20170614194316.uhplmksedwangz43@ws.net.home>
In-Reply-To: <20170614194316.uhplmksedwangz43@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201706151355.47730.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 14 June 2017, Karel Zak wrote:
> [...]
> I don't think we need to change partx.c. IMHO the broken thing is the
> test and it should be fixed by "--nr" (and check stderr :-)

Thanks for explanations, I've fixed the test via github pull request
https://github.com/karelzak/util-linux/pull/462

cu,
Rudi
