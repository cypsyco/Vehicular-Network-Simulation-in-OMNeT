package org.car2x.veins.nodes;

import inet.node.ipv6.StandardHost6;

module CorrespondentNode_IPv6 extends StandardHost6
{
    ipv6.xMIPv6Support = true;
    ipv6.mipv6support.isMobileNode = false;
    ipv6.mipv6support.isHomeAgent = false;

    @display("p=270.405,41.445");
}

