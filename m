Return-Path: luto@kernel.org
MIME-Version: 1.0
In-Reply-To: <ccd7b1ecb6290d245c94ab606bb375b4787b2e1b.1498312679.git.ps@pks.im>
References: <9ace66eed2d16303fd2a8d157875c4acca043f14.1498312679.git.ps@pks.im>
 <cover.1498312509.git.ps@pks.im> <ccd7b1ecb6290d245c94ab606bb375b4787b2e1b.1498312679.git.ps@pks.im>
From: Andy Lutomirski <luto@kernel.org>
Date: Sat, 24 Jun 2017 13:46:18 -0700
Message-ID: <CALCETrU4OfnOe_jKUfrAmThndi++M+j2Ywpm+nRbvrOD1K5mbg@mail.gmail.com>
Subject: Re: [PATCH 4/5] setpriv: support dumping ambient capabilities
To: Patrick Steinhardt <ps@pks.im>
Cc: util-linux@vger.kernel.org, Andrew Lutomirski <luto@kernel.org>,
	Karel Zak <kzak@redhat.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <util-linux.vger.kernel.org>

On Sat, Jun 24, 2017 at 7:04 AM, Patrick Steinhardt <ps@pks.im> wrote:
> Our code dumping owned capabilities does not yet handle ambient
> capabilities, which were only recently introduced with Linux 4.3. This
> commit implements printing ambient capabilities if they're supported by
> the system.
>
> Based on a patch by Andy Lutomirski.
>

Reviewed-by: Andy Lutomirski <luto@kernel.org>
