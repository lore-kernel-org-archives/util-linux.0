Return-Path: heiko.carstens@de.ibm.com
Date: Thu, 9 Aug 2012 12:55:15 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: faizan husain <faizanh@linux.vnet.ibm.com>
Cc: Karel Zak <kzak@redhat.com>, Bernhard Voelker <mail@bernhard-voelker.de>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: limit options --all, --online, --offline to
 parsable and extended output
Message-ID: <20120809105515.GA3574@osiris.de.ibm.com>
References: <20120808085911.GA3441@osiris.de.ibm.com>
 <50235651.6030409@linux.vnet.ibm.com>
 <20120809065759.GA3930@osiris.de.ibm.com>
 <50236466.2030906@linux.vnet.ibm.com>
 <20120809075859.GA6814@osiris.de.ibm.com>
 <50237463.4040401@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50237463.4040401@linux.vnet.ibm.com>
List-ID: <util-linux.vger.kernel.org>

On Thu, Aug 09, 2012 at 01:57:15PM +0530, faizan husain wrote:
> Sorry for creating confusion here,that is correct, lscpu never printed
> columns for architecture, threads per core etc. for the extended and
> parsable output.
> what i feel is earlier we used to have lot of other CPU Architecture
> specific information printed (see man page DESCRIPTION) with -a, -b ,-c
> option but with your patch as -a, -b and -c are used only with -e and -p
> option those column information are suppressed.

Try "lscpu" without any options.
