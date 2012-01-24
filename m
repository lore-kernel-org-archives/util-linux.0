Return-Path: tytso@thunk.org
Date: Mon, 23 Jan 2012 20:06:02 -0500
From: "Ted Ts'o" <tytso@mit.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Roger Leigh <rleigh@codelibre.net>,
        Karel Zak <kzak@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org
Subject: Re: /etc/fstab.d yes or not
Message-ID: <20120124010602.GA27017@thunk.org>
References: <20120120140444.GC13157@x2.net.home>
 <20120120154912.GK8797@codelibre.net>
 <CAPXgP13a9v+f1uNdpe-c+aApLfLpgn15b1-gZxRPd0wMvU=B-Q@mail.gmail.com>
 <20120120162220.GN8797@codelibre.net>
 <CAPXgP11pvch92n1=mMfDsMLoGZMG8xq0e1juXyUO6mxFR6_GYg@mail.gmail.com>
 <ACD4236E-A309-465F-8789-DA3A5B648313@mit.edu>
 <20120123220720.1b2e9663@pyramind.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120123220720.1b2e9663@pyramind.ukuu.org.uk>
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 23, 2012 at 10:07:20PM +0000, Alan Cox wrote:
> 
> So with a good coding hat on - please don't consider fstab API, it's got
> a programming interface 8). Otherwise I agree fstab.d is wrong.
> 

It has a programming interface for reading, but other programs can do
modify (and read) the file directly.  If some joker decided to change
the formatting of /etc/fstab from tab-delimeted to some crazy XML
encoding, I am certain things would break.

					- Ted
