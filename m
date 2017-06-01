Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 0/6] minor last minute fixes for v2.30
Date: Thu, 1 Jun 2017 11:15:10 +0200
Cc: util-linux@vger.kernel.org
References: <1496279320-14541-1-git-send-email-sweet_f_a@gmx.de> <201706010952.43726.sweet_f_a@gmx.de> <20170601085516.vscfhvqtwhixr6hu@ws.net.home>
In-Reply-To: <20170601085516.vscfhvqtwhixr6hu@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201706011115.10999.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Thursday 01 June 2017, Karel Zak wrote:
> On Thu, Jun 01, 2017 at 09:52:43AM +0200, Ruediger Meier wrote:
> > I've fixed some typos via github pull request.
> > https://github.com/karelzak/util-linux/pull/450
>
> Applied, thanks.

Hm, maybe you could revert the stdbuf patch. It does not work on 
OSX/travis.

cu,
Rudi
