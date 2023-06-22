//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
//
import org.car2x.veins.nodes.RSU_IPv6;
import org.car2x.veins.nodes.Scenario_IPv6;
import org.car2x.veins.nodes.Car;
import org.car2x.veins.nodes.MobilityAnchor_IPv6;
import inet.node.ipv6.StandardHost6;
import org.car2x.veins.nodes.CorrespondentNode_IPv6;

channel ethernetline extends ned.DatarateChannel{
	parameters:
	    delay = 0.1us;
	    datarate = 100Mbps;
}


network TestPmipv6 extends Scenario_IPv6
{
    //TODO_2023-1_10000_LINE_PROJECT: Add the CorrespondentNode_IPv6 module which is implemented using StandardHost6.
    // write it by referring to the MobilityAnchor_IPv6
    //Add the connection of Mobility Anchor to CorrespondentNode_IPv6 and to RSU_IPv6  according to the architrecture in the .docx file.
    parameters:
        int n;

        @display("bgb=945,671");
    submodules:
        rsu[n]: RSU_IPv6 {
            @display("p=124.335,104.76375;i=veins/sign/yellowdiamond;is=vs");
        }
        MA[1]: MobilityAnchor_IPv6 {
            @display("p=450.36751,41.445;i=veins/sign/yellowdiamond;is=vs");
        }
       
        //TODO_2023-1_10000_LINE_PROJECT:: CorrespondentNode_IPv6  codes
        CN[1]: CorrespondentNode_IPv6 {
            @display("p=272.405,41.445;i=veins/sign/yellowdiamond;is=vs");
        }

    connections allowunconnected:
        for i=0..n-1 {
            MA[0].ethg$o++ --> ethernetline --> rsu[i].ethg$i++;
            MA[0].ethg$i++ <-- ethernetline <-- rsu[i].ethg$o++;
        }
        
        MA[0].ethg$o++ --> ethernetline --> CN[0].ethg$i++;
        MA[0].ethg$i++ <-- ethernetline <-- CN[0].ethg$o++;
        
        rsu[0].ethg$i++ <-- ethernetline <-- rsu[1].ethg$o++;
        rsu[0].ethg$o++ --> ethernetline --> rsu[1].ethg$i++;
        //        BAM
        rsu[1].ethg$i++ <-- ethernetline <-- rsu[2].ethg$o++;
        rsu[1].ethg$o++ --> ethernetline --> rsu[2].ethg$i++;
}

