Return-Path: mail@bernhard-voelker.de
Message-ID: <53CD86FC.7000808@bernhard-voelker.de>
Date: Mon, 21 Jul 2014 23:32:44 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Benno Schulenberg <bensberg@justemail.net>, Karel Zak <kzak@redhat.com>
CC: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigbrady.com>
Subject: Re: mount.8: mtab as symlink
References: <53CCADA9.3020703@bernhard-voelker.de> <20140721082859.GD17373@x2.net.home> <1405977369.18035.144118445.737362A9@webmail.messagingengine.com>
In-Reply-To: <1405977369.18035.144118445.737362A9@webmail.messagingengine.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 07/21/2014 11:16 PM, Benno Schulenberg wrote:
> So how does umount determine that a device was mounted by a user
> and thus that the user is alllowed to unmount it again?

man sys-utils/mount.8  # the new one! ;-)

   user   Allow  an  ordinary user to mount the filesystem.
          The name of the mounting user is written to mtab
          (or to the private libmount file in /run/mount on
          system without regular mtab) so that he can unmount
          the filesystem again.

Have a nice day,
Berny
